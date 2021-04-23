#-*- coding:utf-8 -*-
from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response # import function that returns the templates of the html pages
from django.http import Http404
import datetime
from django.contrib.auth.decorators import login_required
from django import forms
import cgitb; cgitb.enable()
import cgi, os
from Crypto.PublicKey import RSA # import functions enable generate key
from Crypto.Util.randpool import RandomPool
from Crypto.Cipher import AES,DES # import functions enable to use AES and DES algorithms for encryption and decryption
import codecs
from django.conf import settings
import codecs 
from django.db import connection,transaction
import zlib
import struct
import locale

def encrypt(plaintext, secret): # encrpytion function
    secret = _lazysecret(secret) # secret is the key
    encobj = AES.new(secret, AES.MODE_CFB)
    ciphertext = encobj.encrypt(plaintext)
    return ciphertext

def decrypt(ciphertext, secret): # deccrpytion function
    secret = _lazysecret(secret) # secret is the key
    encobj = AES.new(secret, AES.MODE_CFB)
    plaintext = encobj.decrypt(ciphertext)
    return plaintext

def _lazysecret(secret, blocksize=32, padding='}'): # set the block size of the key
    if not len(secret) in (16, 24, 32):
        return secret + (blocksize - len(secret)) * padding
    return secret
def index(request):
    
    if not request.user.is_authenticated(): # check whether user is authenticated or not
       return HttpResponseRedirect("/login/")
    else:
       if request.GET:
        use = request.user.username
        act=request.GET["act"]
        message = request.GET["message"]
        cursor = connection.cursor()
        cursor.execute("SELECT message.sender,message.issue,message.content, message.item,messagekey FROM message where message.item='"+message+"'")
        rows = cursor.fetchall()
        cursor.execute("SELECT receiver FROM receiveMessage where MessageItem= %s",[message])
        r = cursor.fetchall()
        subject = rows[0][1]
        sender = rows[0][0]
        messagekey = rows[0][4]
        content = rows[0][2]
        if messagekey != 'notenc': # if message is encrypted or not
           content = decrypt(content,messagekey) # Decrtpt content of the message
                          
        s=";"
        a = []
        i=0
        for rr in r:
          a.append(rr[0])
          i=i+1
        to = s.join(a)
        if act == str("forward") or act == str("resumedraft"):
         cursor.execute("Select Count(*) from uploadedFile") # count the data in uploaded file table
         numfile = cursor.fetchall()
         if numfile[0][0] > 0:
            cursor.execute("Delete From uploadedFile where user='"+use+"'")
         cursor.execute("Select filename,messageId,filesize,filetype from sentFile where messageId=%s",[message]) # get data that is related to files from sentFile table
         sentfiles = cursor.fetchall()
         for sentfile in sentfiles:
           cursor.execute("INSERT INTO uploadedFile (filename,user,filesize,filetype) VALUES ('"+sentfile[0]+"','"+use+"','"+sentfile[2]+"','"+sentfile[3]+"')") # insert data that is related to files into uploadedFile table
           transaction.commit()
        cursor.execute("Select fileItem,filename,filesize,filetype from uploadedFile where user='"+use+"'")
        files = cursor.fetchall()
        num_file=0
        for f in files:
            num_file=num_file+1
        return render_to_response('enteg1/compose.html', {'use':use,'act':act,'rows':rows,'r':r,'to':to,'files':files,'num_file':num_file,'subject':subject,'content':content,'sender':sender})
       
       elif request.method == 'POST':
        use = request.user.username
        cursor = connection.cursor()
        if request.POST["action"] == str("Send"):  
           subject = request.POST['subject'] # Get entered subject information
           message = request.POST.get('content', '')
           to = request.POST['receiver'] # Get entered receiver list
           from_email =request.user.username
           a = to.split(";") # Split receiver list according semicolon
           act = "post"
           sub = subject
           
           if to:
              
              if subject.strip() == "": # if subject left empty, system fills this part as No Subject
                 subject = "No Subject"
              else:
                subject = sub
              sifrele = request.POST.getlist("sifrele") # checkbox is related to sending encrypted message
              cursor = connection.cursor()
              if to.find("'") > -1:  
                  to = to.replace("'","")
              if len(sifrele) > 0: # if checkbox is selected
                
                pool = RandomPool()
                pool.stir()
                rsa = RSA.generate(128, pool.get_bytes)
                k = str(rsa.n)
                k = k[0:15]
                u= message.encode("utf-8") # encode message to utf8 for encryption
                message = encrypt(u, k)
                try:
                
                  cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'"+from_email+"',CURDATE(),%s,'outbox','+',CURTIME(),'"+k+"')",[message,subject]) # insert ciphertext of the message content to message table
                  transaction.commit()
                except:
                  pass
              else: # if checkbox is not selected
                cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'"+from_email+"',CURDATE(),%s,'outbox','+',CURTIME(),'notenc')",[message,subject]) # insert plain of the message content to message table
                transaction.commit()
                
              cursor.execute("SELECT Count(*) from message where sender='"+from_email+"'") # count the number of rows in message table
              row = cursor.fetchall()
              count = row[0][0]-1
              cursor.execute("SELECT item from message where sender='"+from_email+"' LIMIT %s,1",[count]) # get last message that this user has sent
              row = cursor.fetchall()
              item = row[0][0]
              cursor.execute("Select fileItem,filename,filesize,filetype from uploadedFile where user='"+use+"'") # get the updated data from upladedFile table
              files = cursor.fetchall()
              num_file=0
              for f in files:
                 num_file = num_file+1
              if num_file > 0:
                for f in files:
                 cursor.execute("INSERT INTO sentFile (filename,messageId,filesize,filetype) VALUES('"+f[1]+"',%s,'"+f[2]+"','"+f[3]+"')",[item])  # insert data that is related to attached file to sentFile table
                 transaction.commit()
                cursor.execute("Delete From uploadedFile where user='"+use+"'")
                transaction.commit()
              i=0
              cursor.execute("INSERT INTO outbox (messageItem,outbox_from,user,isread) VALUES(%s,'outbox','"+from_email+"','+')",[item]) #insert message data that belongs to recievers to outbox table
              transaction.commit()
              cursor.execute("SELECT Count(*) from message where sender='"+from_email+"'")
              row = cursor.fetchall()
              count = row[0][0]-1
              cursor.execute("SELECT item,sent_date,sent_time from message where sender='"+from_email+"' LIMIT %s,1",[count])
              row = cursor.fetchall()
              logfile = codecs.open("sent_emails.txt","a","utf-8")
              logfile.write(str(row[0][0])+" "+from_email+" "+"'"+subject+"'"+" "+to+" "+str(row[0][1])+" "+str(row[0][2])+"\n") # write message information to log file
              logfile.close()
              s =""
              while i < len(a):
                cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,mailbox_receiver,receive_date,receive_time,isread,is_decrypt) VALUES('"+a[i]+"',%s,'inbox',CURDATE(),CURTIME(),'-','0')",[item]) # insert message data that belongs to recievers to receiveMessage table
                transaction.commit()
                cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES(%s,'inbox','"+a[i]+"','-')",[item]) # insert message data that belongs to recievers to inbox table
                transaction.commit()
                cursor.execute("SELECT Count(*) from receiveMessage where MessageItem=%s",[item])
                r = cursor.fetchall()
                count = r[0][0]-1
                cursor.execute("SELECT receive_date,receive_time from receiveMessage where MessageItem=%s LIMIT %s,1",[item,count])
                ra = cursor.fetchall()
                cursor.execute("SELECT issue,content from message where item=%s",[item])
                re = cursor.fetchall()
                cursor.execute("Select Count(*) from auth_user where username ='"+a[i]+"'")
                num_user = cursor.fetchall()
                if num_user[0][0] > 0:
                 s = "Message is sent successfully to :"+str(a[i])+"\nReceive Date: "+str(ra[0][0])+"\nReceive Time: "+str(ra[0][1])+"\nSubject: "+re[0][0] # the content of the delivered report
                 cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'EGHPP System',CURDATE(),'report:sent','outbox','+',CURTIME(),'notenc')",[s]) # insert data that is related to delivered report to message table
                 transaction.commit()
                 cursor.execute("SELECT Count(*) from message where sender='EGHPP System'")
                 row = cursor.fetchall()
                 count = row[0][0]-1
                 cursor.execute("SELECT item from message where sender='EGHPP System' LIMIT %s,1",[count])
                 row = cursor.fetchall()
                 message_item = row[0][0]
                 cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,mailbox_receiver,receive_date,receive_time,isread) VALUES('"+from_email+"',%s,'inbox',CURDATE(),CURTIME(),'-')",[message_item])
                 transaction.commit()
                 cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES(%s,'inbox','"+from_email+"','-')",[message_item])
                 transaction.commit() # insert data that is related to delivered report to inbox table
                else:
                 s = "Message is not delivered to :'"+str(a[i])+"' Beceause '"+str(a[i])+"' is not registered in the system" # the content of the not delivered report
                 cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'EGHPP System',CURDATE(),'report:notsent','outbox','+',CURTIME(),'notenc')",[s]) # insert data that is related to not delivered report to message table
                 transaction.commit()
                 cursor.execute("SELECT Count(*) from message where sender='EGHPP System'") # count number of rows in message table
                 row = cursor.fetchall()
                 count = row[0][0]-1
                 cursor.execute("SELECT item from message where sender='EGHPP System' LIMIT %s,1",[count]) # Get the last message that EGHPP System has sent
                 row = cursor.fetchall()
                 message_item = row[0][0]
                 cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,mailbox_receiver,receive_date,receive_time,isread) VALUES('"+from_email+"',%s,'inbox',CURDATE(),CURTIME(),'-')",[message_item]) # insert message data that belongs to recievers to receiveMessage table
                 transaction.commit()
                 cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES(%s,'inbox','"+from_email+"','-')",[message_item])
                 transaction.commit() # insert data that is related to not delivered report to inbox table
                i = i + 1
              return render_to_response("enteg1/compose_redirect.html",{'a':a,'i':i,'use':use}) # return the template of the compose_redirect.html page After message is sent
              
            
           else: # if receiver part is empty
            sentence = "*Receiver part cannot be empty"
            cursor.execute("Select fileItem,filename,filesize,filetype from uploadedFile where user='"+use+"'") # show the updated data in uploadedFile
            files = cursor.fetchall()
            num_file=0
            for f in files:
              num_file=num_file+1
            return render_to_response('enteg1/compose.html', {'use':use,'files':files,'num_file':num_file,'subject':subject,'message':message,'to':to,'act':act,'sentence':sentence})
        elif request.POST["action"] == str("SaveDraft"): # user press SaveDraft button
           subject = request.POST['subject'] # Get entered subject from form
           message = request.POST['content'] # Get entered content from form
           from_email =request.user.username
           sub = subject
           if sub == "" or sub == " ": # if subject left empty, system fills this part as No Subject
            sub = "No subject"
           else:
             sub = subject
           to = request.POST['receiver']
           if to.find("'") > -1:
                  to = to.replace("'","")
           a = to.split(";")
           cursor = connection.cursor()
           cursor.execute("INSERT INTO message (content,sender,sent_date,issue,mailbox_sender,isread,sent_time,messagekey) VALUES(%s,'"+from_email+"',CURDATE(),%s,'outbox','+',CURTIME(),'notenc')",[message,sub]) # insert message data to message table but it is not sent to receivers, messages are saved as draft in database
           transaction.commit()
           cursor.execute("SELECT Count(*) from message") # count number of row in message table
           row = cursor.fetchall()
           count = row[0][0]-1
           cursor.execute("SELECT item from message LIMIT %s,1",[count]) # Get the item of the last message
           row = cursor.fetchall()
           item = row[0][0]
           cursor.execute("INSERT INTO draft (messageId,draft_from,user,isread) VALUES(%s,'outbox','"+from_email+"','+')",[item]) # insert message data to draft table
           transaction.commit()
           cursor.execute("Select fileItem,filename,filesize,filetype from uploadedFile where user='"+use+"'")
           files = cursor.fetchall()
           num_file=0
           for f in files:
               num_file = num_file+1
           if num_file > 0:
              for f in files:
               cursor.execute("INSERT INTO sentFile (filename,messageId,filesize,filetype) VALUES('"+f[1]+"',%s,'"+f[2]+"','"+f[3]+"')",[item]) # insert data that is related to attached file to sentFile table
               transaction.commit()
              cursor.execute("Delete From uploadedFile where user='"+use+"'")
              transaction.commit()
           i=0
           while i < len(a):
             cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,receive_date,receive_time,mailbox_receiver,isread) VALUES('"+a[i]+"',%s,CURDATE(),CURTIME(),'draft','+')",[item])
             transaction.commit() 
             cursor.execute("INSERT INTO draftToReceiver (messageItem,draft_from,user,isread) VALUES (%s,'draft','"+a[i]+"','+')",[item])
             transaction.commit() # insert message data to drafttoReceiver table for receivers
             i = i + 1
           return HttpResponseRedirect("/draft/?page=1")
        elif request.POST["action"] == str("AttachFiles"): # if user presses AttachFiles button
         subject = request.POST['subject']
         message = request.POST['content']
         to = request.POST['receiver']
         try: # upload the file(s)
           item = request.FILES['filead'] # get uploaded file from form
           fout = file (os.path.join("uploadedfile", item.name), 'wb')
           while 1:
             chunk = item.file.read(100000)
             if not chunk: break
             fout.write (chunk)
           fout.close()
           size = str(item.size) # size of the file
           cursor.execute("INSERT INTO uploadedFile (filename,filesize,user,filetype) VALUES ('"+item.name+"','"+size+"','"+use+"','"+item.content_type+"')") # insert data that is related to uploaded file to uploadFile table
           cursor.execute("Select fileItem,filename,filesize,filetype from uploadedFile where user='"+use+"'") # show the updated data in uploadFile table
           files = cursor.fetchall()
           num_file=0 # number of attached files
           for f in files:
              num_file=num_file+1
           act = "post"
           return render_to_response('enteg1/compose.html', {'use':use,'files':files,'num_file':num_file,'subject':subject,'message':message,'to':to,'act':act}) # show entered data
         except:
           cursor.execute("Select fileItem,filename,filesize,filetype from uploadedFile where user='"+use+"'")
           files = cursor.fetchall()
           num_file=0
           for f in files:
             num_file=num_file+1
           act = "post"
           return render_to_response('enteg1/compose.html', {'use':use,'files':files,'num_file':num_file,'subject':subject,'message':message,'to':to,'act':act})
       
        elif request.POST["action"] == str("Delete selected attachment"): # if user presses Delete Selected Attachment
         subject = request.POST['subject'] # Get entered subject from form
         message = request.POST['content'] # Get entered content from form
         to = request.POST['receiver']
         for select in request.POST.getlist("files"):
            cursor.execute("Select fileItem,filename from uploadedFile where fileItem='"+select+"'")
            filess =  cursor.fetchall()
            fileitem = filess[0][0]
            filename = filess[0][1]
            cursor.execute("Delete From uploadedFile where fileItem=%s",[fileitem]) # Delete data that is related to uploadFile from uploadedFile
            transaction.commit()
         cursor.execute("Select fileItem,filename,filesize,filetype from uploadedFile where user='"+use+"'")
         files = cursor.fetchall()
         num_file=0 # number of attached files
         for f in files:
            num_file=num_file+1
         act = "post"
         return render_to_response('enteg1/compose.html', {'use':use,'files':files,'num_file':num_file,'subject':subject,'message':message,'to':to,'act':act})
       else:
        count=0
        use = request.user.username
        cursor = connection.cursor()
        act="compose"
        cursor.execute("Delete from uploadedFile where user='"+use+"'") # if compose page is opened, data is deleted from uploadedFie
        num_file=0
        return render_to_response('enteg1/compose.html', {'use':use,'act':act,'num_file':num_file})



