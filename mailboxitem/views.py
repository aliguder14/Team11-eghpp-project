#-*- coding:utf-8 -*-
from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response
from django.http import Http404
from django.contrib.auth.decorators import login_required
from django.core.mail import send_mail
from Crypto.PublicKey import RSA
from Crypto.Util.randpool import RandomPool
from Crypto.Cipher import AES,DES
from django.core.mail import send_mail, BadHeaderError
from datetime import date
def encrypt(plaintext, secret): # Encryption Function
    secret = _lazysecret(secret)
    encobj = AES.new(secret, AES.MODE_CFB)
    ciphertext = encobj.encrypt(plaintext)
    return ciphertext

def decrypt(ciphertext, secret): # Decryption Function
    secret = _lazysecret(secret)
    encobj = AES.new(secret, AES.MODE_CFB)
    plaintext = encobj.decrypt(ciphertext)
    return plaintext

def _lazysecret(secret, blocksize=32, padding='}'): # This function enables to set the block size of the key
    if not len(secret) in (16, 24, 32):
        return secret + (blocksize - len(secret)) * padding
    return secret
def DateFormat(date): # Showing months in letter format
  dates = date.split("-")
  month = ""
  if dates[1] == "01":
    month = "January"
  elif dates[1] == "02":
    month = "February"
  elif dates[1] == "03":
    month = "March"
  elif dates[1] == "04":
    month = "April"
  elif dates[1] == "05":
    month = "May"
  elif dates[1] == "06":
    month = "June"
  elif dates[1] == "07":
    month = "July"
  elif dates[1] == "08":
    month = "August"
  elif dates[1] == "09":
    month = "September"
  elif dates[1] == "10":
    month = "October"
  elif dates[1] == "11":
    month = "November"
  elif dates[1] == "12":
    month = "December"
  day = ""
  if dates[2][0] == "0":
    day = dates[2][1]
  else:
    day = dates[2]
  
  new_format = month+" "+day+", "+dates[0]
  return new_format
def showWeekDay(dates): # Showing weekdays in letter format
   dates = dates.split("-")
   year = int(dates[0])
   month = int(dates[1])
   day =  int(dates[2])
   eventDate = date(year,month,day)
   dayofWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'] # list of days
   weekDay = dayofWeek[date.weekday(eventDate)]
   return weekDay
def index(request):
    from django.db import connection,transaction
    if not request.user.is_authenticated():
       return HttpResponseRedirect("/login/")
    else:
       use = request.user.username
       item = request.GET["id"] # the item of the message
       page = request.GET["page"] # mailbox type
       count=0
       link=""
       cursor = connection.cursor()
       if page == str("outbox"):
         cursor.execute("Select receiveMessage.isread,outbox.isread,outbox.outboxItem,receiveMessage.receiver,receiveMessage.MessageItem,outbox.outbox_from,message.sender,message.issue,message.content From outbox,receiveMessage,message where outbox.messageItem=receiveMessage.MessageItem and outbox.messageItem=message.item and outbox.outboxItem='"+item+"' Group By outbox.outboxItem") 
         ro = cursor.fetchall()
         messageitem = ro[0][4]
         if ro[0][0] == "-" and ro[0][1] == "-" and ro[0][5] == "inbox" and ro[0][6] != "EGHPP System":
            cursor.execute("Update receiveMessage set isread='+' where MessageItem=%s and receiver='"+use+"'",[messageitem])
            transaction.commit()
            s = "Message is read from :"+str(use)+"\nSubject: "+ro[0][7] # the content of the read report
            cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'EGHPP System',CURDATE(),'report:read','outbox','+',CURTIME(),'notenc')",[s]) # insert the data that are related to read report as message to message table 
            transaction.commit()
            cursor.execute("SELECT Count(*) from message where sender='EGHPP System'")
            row = cursor.fetchall()
            count = row[0][0]-1
            cursor.execute("SELECT item from message where sender='EGHPP System' LIMIT %s,1",[count]) # get the last message that EGHPP System has sent
            row = cursor.fetchall()
            message_item = row[0][0]
            cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,mailbox_receiver,receive_date,receive_time,isread) VALUES('"+ro[0][6]+"',%s,'inbox',CURDATE(),CURTIME(),'-')",[message_item])
            transaction.commit()
            cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES(%s,'inbox','"+ro[0][6]+"','-')",[message_item]) # insert data that is related to read report
            transaction.commit()
            
         if ro[0][1] == "-": # if message has been uread, message will be read
            cursor.execute("UPDATE outbox set isread='+' where outboxItem='"+item+"'")
            transaction.commit()
         cursor.execute("SELECT message.sender,message.sent_date,message.sent_time,message.issue,message.content,message.item,outbox.outboxItem,message.messagekey FROM message, receiveMessage,outbox where receiveMessage.MessageItem = message.item and message.item= outbox.messageItem and outbox.outboxItem='"+item+"' LIMIT 0,1")
         rows = cursor.fetchall()
         me_content = rows[0][4]
         date = DateFormat(str(rows[0][1])) # show months in letter format
         if rows[0][7] != 'notenc': # check whether message is encrypted or not
            me_content = decrypt(rows[0][4],rows[0][7]) # decrypt message for this user
         mesg = rows[0][5]
         weekday= showWeekDay(str(rows[0][1])) # show week day in letter format
         cursor.execute("SELECT receiver FROM receiveMessage where MessageItem= %s",[mesg])
         r = cursor.fetchall()
         cursor.execute("Select filename from sentFile where messageId=%s",[mesg])
         files = cursor.fetchall()
         num_file=0
         for f in files:
           num_file= num_file+1
         return render_to_response('enteg1/mailboxitem.html', {'use':use,'rows':rows,'r':r,'link':link,'mesg':mesg,'files':files,'num_file':num_file,'me_content':me_content,'date':date,'weekday':weekday})
       elif page == str("inbox"):
         cursor.execute("Select receiveMessage.isread,inbox.isread,inbox.inboxItem,receiveMessage.receiver,receiveMessage.MessageItem,inbox.inbox_from,message.sender,message.issue,message.content From inbox,receiveMessage,message where inbox.messageItem=receiveMessage.MessageItem and inbox.messageItem=message.item and inbox.inboxItem='"+item+"' Group By inbox.inboxItem") # get the data from tables
         ro = cursor.fetchall()
         messageitem = ro[0][4]
         if ro[0][0] == "-" and ro[0][1] == "-" and ro[0][5] == "inbox" and ro[0][6] != "EGHPP System": # check whether message has been read and sender is EGHPP System and user recieves this message or not
            cursor.execute("Update receiveMessage set isread='+' where MessageItem=%s and receiver='"+use+"'",[messageitem])
            transaction.commit()
            s = "Message is read from :"+str(use)+"\nSubject: "+ro[0][7]
            cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'EGHPP System',CURDATE(),'report:read','outbox','+',CURTIME(),'notenc')",[s])
            transaction.commit()
            cursor.execute("SELECT Count(*) from message where sender='EGHPP System'")
            row = cursor.fetchall()
            count = row[0][0]-1
            cursor.execute("SELECT item from message where sender='EGHPP System' LIMIT %s,1",[count])
            row = cursor.fetchall()
            message_item = row[0][0]
            cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,mailbox_receiver,receive_date,receive_time,isread) VALUES('"+ro[0][6]+"',%s,'inbox',CURDATE(),CURTIME(),'-')",[message_item])
            transaction.commit()
            cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES(%s,'inbox','"+ro[0][6]+"','-')",[message_item])
            transaction.commit()
         if ro[0][1] == "-":
            cursor.execute("UPDATE inbox set isread='+' where inboxItem='"+item+"'")
            transaction.commit()
         cursor.execute("SELECT message.sender,receiveMessage.receive_date,receiveMessage.receive_time,message.issue,message.content,message.item,inbox.inboxItem,message.messagekey FROM message, receiveMessage,inbox where receiveMessage.MessageItem = message.item and message.item= inbox.messageItem and inbox.inboxItem='"+item+"' LIMIT 0,1")
         rows = cursor.fetchall()
         me_content = rows[0][4]
         if rows[0][7] != 'notenc':
            me_content = decrypt(rows[0][4],rows[0][7])
         weekday= showWeekDay(str(rows[0][1]))  
         mesg = rows[0][5]
         date = DateFormat(str(rows[0][1]))
         for ro in rows:
           count = count+1
         cursor.execute("SELECT receiver FROM receiveMessage where MessageItem= %s",[mesg])
         r = cursor.fetchall()
         cursor.execute("Select filename from sentFile where messageId=%s",[mesg])
         files = cursor.fetchall()
         num_file=0
         for f in files:
           num_file= num_file+1
         return render_to_response('enteg1/mailboxitem.html', {'use':use,'rows':rows,'r':r,'link':link,'mesg':mesg,'files':files,'num_file':num_file,'me_content':me_content,'date':date,'weekday':weekday})
       elif page == str("draft"):
         cursor.execute("Select receiveMessage.isread,draft.isread,draft.draftId,receiveMessage.receiver,receiveMessage.MessageItem,draft.draft_from,message.sender,message.issue,message.content From draft,receiveMessage,message where draft.messageId=receiveMessage.MessageItem and draft.messageId=message.item and draft.draftId='"+item+"' group By draftId")
         ro = cursor.fetchall()
         messageitem = ro[0][4]
         if ro[0][0] == "-" and ro[0][1] == "-" and ro[0][5] == "inbox" and ro[0][6] != "EGHPP System":
            cursor.execute("Update receiveMessage set isread='+' where MessageItem=%s and receiver='"+use+"'",[messageitem])
            transaction.commit()
            s = "Message is read from :"+str(use)+"\nSubject: "+ro[0][7]
            cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'EGHPP System',CURDATE(),'report:read','outbox','+',CURTIME(),'notenc')",[s])
            transaction.commit()
            cursor.execute("SELECT Count(*) from message where sender='EGHPP System'")
            row = cursor.fetchall()
            count = row[0][0]-1
            cursor.execute("SELECT item from message where sender='EGHPP System' LIMIT %s,1",[count])
            row = cursor.fetchall()
            message_item = row[0][0]
            cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,mailbox_receiver,receive_date,receive_time,isread) VALUES('"+ro[0][6]+"',%s,'inbox',CURDATE(),CURTIME(),'-')",[message_item])
            transaction.commit()
            cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES(%s,'inbox','"+ro[0][6]+"','-')",[message_item])
            transaction.commit()
         if ro[0][1] == "-":
            cursor.execute("UPDATE draft set isread='+' where draftId='"+item+"'")
            transaction.commit()
         cursor.execute("SELECT message.sender,message.sent_date,message.sent_time,message.issue,message.content,message.item,draft.draftId, message.messagekey FROM message,receiveMessage,draft where receiveMessage.MessageItem = message.item and message.item= draft.messageId and draft.draftId='"+item+"' LIMIT 0,1")
         rows = cursor.fetchall()
         me_content = rows[0][4]
         if rows[0][7] != 'notenc':
            me_content = decrypt(rows[0][4],rows[0][7])
         link = "Resume Draft"
         date = DateFormat(str(rows[0][1]))
         weekday= showWeekDay(str(rows[0][1]))
         mesg = rows[0][5]
         for ro in rows:
           count = count+1
         cursor.execute("SELECT receiver FROM receiveMessage where MessageItem= %s",[mesg])
         r = cursor.fetchall()
         cursor.execute("Select filename from sentFile where messageId=%s",[mesg])
         files = cursor.fetchall()
         num_file=0
         for f in files:
           num_file= num_file+1
         return render_to_response('enteg1/mailboxitem.html', {'use':use,'rows':rows,'r':r,'link':link,'mesg':mesg,'files':files,'num_file':num_file,'me_content':me_content,'date':date,'weekday':weekday})
       elif page == str("deleted"):
         cursor.execute("Select receiveMessage.isread,deleteMessage.isread,deleteMessage.deletedItem,receiveMessage.receiver,receiveMessage.MessageItem,deleteMessage.delete_from,message.sender,message.issue,message.content From deleteMessage,receiveMessage,message where deleteMessage.messageItem=receiveMessage.MessageItem and deleteMessage.messageItem=message.item and deleteMessage.deletedItem='"+item+"' Group By deleteMessage.deletedItem")
         ro = cursor.fetchall()
         messageitem = ro[0][4]
         if ro[0][0] == "-" and ro[0][1] == "-" and ro[0][5] == "inbox" and ro[0][6] != "EGHPP System":
            cursor.execute("Update receiveMessage set isread='+' where MessageItem=%s and receiver='"+use+"'",[messageitem])
            transaction.commit()
            s = "Message is read from :"+str(use)+"\nSubject: "+ro[0][7]
            cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'EGHPP System',CURDATE(),'report:read','outbox','+',CURTIME(),'notenc')",[s])
            transaction.commit()
            cursor.execute("SELECT Count(*) from message where sender='EGHPP System'")
            row = cursor.fetchall()
            count = row[0][0]-1
            cursor.execute("SELECT item from message where sender='EGHPP System' LIMIT %s,1",[count])
            row = cursor.fetchall()
            message_item = row[0][0]
            cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,mailbox_receiver,receive_date,receive_time,isread) VALUES('"+ro[0][6]+"',%s,'inbox',CURDATE(),CURTIME(),'-')",[message_item])
            transaction.commit()
            cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES(%s,'inbox','"+ro[0][6]+"','-')",[message_item])
            transaction.commit()
         if ro[0][1] == "-":
            cursor.execute("UPDATE deleteMessage set isread='+' where deletedItem='"+item+"'")
            transaction.commit()
         cursor.execute("SELECT message.sender,receiveMessage.receive_date,receiveMessage.receive_time,message.issue,message.content,message.item,deleteMessage.deletedItem,message.messagekey FROM message,receiveMessage,deleteMessage where receiveMessage.MessageItem = message.item and message.item= deleteMessage.messageItem and deleteMessage.deletedItem='"+item+"' LIMIT 0,1")
         rows = cursor.fetchall()
         me_content = rows[0][4]
         if rows[0][7] != 'notenc':
            me_content = decrypt(rows[0][4],rows[0][7])
         mesg = rows[0][5]
         date = DateFormat(str(rows[0][1]))
         weekday= showWeekDay(str(rows[0][1]))
         cursor.execute("SELECT receiver FROM receiveMessage where MessageItem= %s",[mesg])
         r = cursor.fetchall()
         cursor.execute("Select filename from sentFile where messageId=%s",[mesg])
         files = cursor.fetchall()
         num_file=0
         for f in files:
           num_file= num_file+1
         return render_to_response('enteg1/mailboxitem.html', {'use':use,'rows':rows,'r':r,'link':link,'mesg':mesg,'files':files,'num_file':num_file,'me_content':me_content,'date':date,'weekday':weekday})  
