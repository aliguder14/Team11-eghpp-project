#-*- coding:utf-8 -*-
from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response
from django.http import Http404
import datetime
from django.contrib.auth.decorators import login_required
import cgitb; cgitb.enable()
from django import forms
import cgi, os
from django.db import connection,transaction
from django.conf import settings
import csv
def index(request):
 if not request.user.is_authenticated() or not request.user.is_superuser: 
       return HttpResponseRedirect("/login/")
 else:
  try:
   ofile  = open('backupfile/mailbox.csv')
   reader = csv.reader(ofile, delimiter=' ')
   cursor = connection.cursor()
   j=0
   for row in reader:

     if j != 0: # check whethet row consists of titles
          
       if row[16] == "inbox": # if mailbox type is inbox
             cursor.execute("Select item,sender,issue,content,sent_date,sent_time,mailbox_sender from message where item=%s",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               try: 
                 cursor.execute("INSERT INTO message (item,sender,issue,content,sent_date,sent_time,mailbox_sender,messagekey) VALUES(%s,'"+row[2]+"',%s,%s,%s,%s,'"+row[12]+"','"+row[15]+"')",[row[9],row[7],str(row[8]),row[3],row[4]]) # insert data that has been got from mailbox.csv to message table
                 transaction.commit()
               except:
                  pass 
             cursor.execute("Select Count(*),isread,messageItem,user,inbox_from from inbox where inboxItem=%s",[row[10]])
             r = cursor.fetchall()
             if r[0][0] == 0:
              if row[11] == "inbox": # if message is received by user
               cursor.execute("INSERT INTO inbox (inboxItem,messageItem,user,isread,inbox_from) VALUES (%s,%s,'"+row[0]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to inbox table
               transaction.commit()
              elif row[11] == "outbox": # if message is sent by user
               cursor.execute("INSERT INTO inbox (inboxItem,messageItem,user,isread,inbox_from) VALUES (%s,%s,'"+row[2]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to inbox table
               transaction.commit()
              
             cursor.execute("Select MessageItem,receiver,receive_date,receive_time,mailbox_receiver,isread from receiveMessage where MessageItem=%s and receiver='"+row[0]+"'",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,receive_date,receive_time,mailbox_receiver,isread) VALUES('"+row[0]+"',%s,%s,%s,'"+row[13]+"','"+row[14]+"')",[row[9],row[5],row[6]]) # insert data that has been got from mailbox.csv to receiveMessage table
               transaction.commit()
               

       elif row[16] == "outbox": # if mailbox type is outbox
             cursor.execute("Select item,sender,issue,content,sent_date,sent_time,mailbox_sender from message where item=%s",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               try: 
                 cursor.execute("INSERT INTO message (item,sender,issue,content,sent_date,sent_time,mailbox_sender,messagekey) VALUES(%s,'"+row[2]+"',%s,%s,%s,%s,'"+row[12]+"','"+row[15]+"')",[row[9],row[7],str(row[8]),row[3],row[4]]) # insert data that has been got from mailbox.csv to message table
                 transaction.commit()
               except:
                  pass 
             cursor.execute("Select Count(*),isread,messageItem,user,outbox_from from outbox where outboxItem=%s",[row[10]])
             r = cursor.fetchall()
             if r[0][0] == 0:
              if row[11] == "inbox": # if message is received by user
               cursor.execute("INSERT INTO outbox (outboxItem,messageItem,user,isread,outbox_from) VALUES (%s,%s,'"+row[0]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to outbox table
               transaction.commit()
              elif row[11] == "outbox": # if message is sent by user
               cursor.execute("INSERT INTO outbox (outboxItem,messageItem,user,isread,outbox_from) VALUES (%s,%s,'"+row[2]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to outbox table
               transaction.commit()
              
             cursor.execute("Select MessageItem,receiver,receive_date,receive_time,mailbox_receiver,isread from receiveMessage where MessageItem=%s and receiver='"+row[0]+"'",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,receive_date,receive_time,mailbox_receiver,isread) VALUES('"+row[0]+"',%s,%s,%s,'"+row[13]+"','"+row[14]+"')",[row[9],row[5],row[6]]) # insert data that has been got from mailbox.csv to receiveMessage table
               transaction.commit()
             
       elif row[16] == "draft": # if mailbox type is draft
             cursor.execute("Select item,sender,issue,content,sent_date,sent_time,mailbox_sender from message where item=%s",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               try: 
                 cursor.execute("INSERT INTO message (item,sender,issue,content,sent_date,sent_time,mailbox_sender,messagekey) VALUES(%s,'"+row[2]+"',%s,%s,%s,%s,'"+row[12]+"','"+row[15]+"')",[row[9],row[7],str(row[8]),row[3],row[4]]) # insert data that has been got from mailbox.csv to message table
                 transaction.commit()
               except:
                  pass 
             cursor.execute("Select Count(*),isread,messageId,user,draft_from from draft where draftId=%s",[row[10]])
             r = cursor.fetchall()
             if r[0][0] == 0:
              if row[11] == "inbox": # if message is received by user
               cursor.execute("INSERT INTO draft (draftId,messageId,user,isread,draft_from) VALUES (%s,%s,'"+row[0]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to draft table
               transaction.commit()
              elif row[11] == "outbox": # if message is sent by user
               cursor.execute("INSERT INTO draft (draftId,messageId,user,isread,draft_from) VALUES (%s,%s,'"+row[2]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]])
               transaction.commit()
              
             cursor.execute("Select MessageItem,receiver,receive_date,receive_time,mailbox_receiver,isread from receiveMessage where MessageItem=%s and receiver='"+row[0]+"'",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,receive_date,receive_time,mailbox_receiver,isread) VALUES('"+row[0]+"',%s,%s,%s,'"+row[13]+"','"+row[14]+"')",[row[9],row[5],row[6]]) # insert data that has been got from mailbox.csv to receiveMessage table
               transaction.commit()
   
       elif row[16] == "deleted": # if mailbox type is deleted
             cursor.execute("Select item,sender,issue,content,sent_date,sent_time,mailbox_sender from message where item=%s",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               try: 
                 cursor.execute("INSERT INTO message (item,sender,issue,content,sent_date,sent_time,mailbox_sender,messagekey) VALUES(%s,'"+row[2]+"',%s,%s,%s,%s,'"+row[12]+"','"+row[15]+"')",[row[9],row[7],str(row[8]),row[3],row[4]]) # insert data that has been got from mailbox.csv to message table
                 transaction.commit()
               except:
                  pass 
             cursor.execute("Select Count(*),isread,messageItem,user,delete_from from deleteMessage where deletedItem=%s",[row[10]])
             r = cursor.fetchall()
             if r[0][0] == 0:
              if row[11] == "inbox": # if message is received by user
               cursor.execute("INSERT INTO deleteMessage (deletedItem,messageItem,user,isread,delete_from) VALUES (%s,%s,'"+row[0]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to deleteMessage table
               transaction.commit()
              elif row[11] == "outbox": # if message is sent by user
               cursor.execute("INSERT INTO deleteMessage (deletedItem,messageItem,user,isread,delete_from) VALUES (%s,%s,'"+row[2]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]])
               transaction.commit()
              
             cursor.execute("Select MessageItem,receiver,receive_date,receive_time,mailbox_receiver,isread from receiveMessage where MessageItem=%s and receiver='"+row[0]+"'",[row[9]]) # insert data that has been got from mailbox.csv to receiveMessage table
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,receive_date,receive_time,mailbox_receiver,isread) VALUES('"+row[0]+"',%s,%s,%s,'"+row[13]+"','"+row[14]+"')",[row[9],row[5],row[6]])
               transaction.commit()

       elif row[16] == "deletedcompletely": # if mailbox type is deletedcompletely
             cursor.execute("Select item,sender,issue,content,sent_date,sent_time,mailbox_sender from message where item=%s",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               try: 
                 cursor.execute("INSERT INTO message (item,sender,issue,content,sent_date,sent_time,mailbox_sender,messagekey) VALUES(%s,'"+row[2]+"',%s,%s,%s,%s,'"+row[12]+"','"+row[15]+"')",[row[9],row[7],str(row[8]),row[3],row[4]]) # insert data that has been got from mailbox.csv to message table
                 transaction.commit()
               except:
                  pass 
             cursor.execute("Select Count(*),isread,messageItem,user,deleted_from from deletedComplete where deletedItem=%s",[row[10]])
             r = cursor.fetchall()
             if r[0][0] == 0:
              if row[11] == "inbox": # if message is received by user
               cursor.execute("INSERT INTO deletedComplete (deletedItem,messageItem,user,isread,deleted_from) VALUES (%s,%s,'"+row[0]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to deleteComplete table
               transaction.commit()
              elif row[11] == "outbox": # if message is sent by user
               cursor.execute("INSERT INTO deletedComplete (deletedItem,messageItem,user,isread,deleted_from) VALUES (%s,%s,'"+row[2]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]])
               transaction.commit()
              
             cursor.execute("Select MessageItem,receiver,receive_date,receive_time,mailbox_receiver,isread from receiveMessage where MessageItem=%s and receiver='"+row[0]+"'",[row[9]]) 
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,receive_date,receive_time,mailbox_receiver,isread) VALUES('"+row[0]+"',%s,%s,%s,'"+row[13]+"','"+row[14]+"')",[row[9],row[5],row[6]]) # insert data that has been got from mailbox.csv to receiveMessage table
               transaction.commit()

       elif row[16] == "drafttoreceiver": # if mailbox type is draftToreceiver
       
             cursor.execute("Select Count(*),isread,messageItem,user,draft_from from draftToReceiver where item=%s",[row[10]])
             r = cursor.fetchall()
             if r[0][0] == 0:
               cursor.execute("INSERT INTO draftToReceiver (item,messageItem,user,isread,draft_from) VALUES (%s,%s,'"+row[0]+"','"+row[1]+"','"+row[11]+"')",[row[10],row[9]]) # insert data that has been got from mailbox.csv to draftToReceiver table
               transaction.commit()
             cursor.execute("Select MessageItem,receiver,receive_date,receive_time,mailbox_receiver,isread from receiveMessage where MessageItem=%s and receiver='"+row[0]+"'",[row[9]])
             messages = cursor.fetchall()
             countmessage = 0
             for message in messages:
               countmessage = countmessage+1
             if countmessage == 0:
               cursor.execute("INSERT INTO receiveMessage (receiver,MessageItem,receive_date,receive_time,mailbox_receiver,isread) VALUES('"+row[0]+"',%s,%s,%s,'"+row[13]+"','"+row[14]+"')",[row[9],row[5],row[6]]) #insert data that has been got from mailbox.csv to receiveMessage table
               transaction.commit()
 
     j=j+1 # increment j by 1
   ofile.close()
   sentence = "Data have been restored sucessfully"
   return render_to_response("enteg1/restore.html",{'sentence':sentence}) # return sentece to html page
  except IOError:
   sentence = "File is not found"
   return render_to_response("enteg1/restore.html",{'sentence':sentence}) # return sentece to html page
   
    

