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
import csv
def index(request):
   if not request.user.is_authenticated() or not request.user.is_superuser:
       return HttpResponseRedirect("/login/")
   else:
    ofile  = open('backupfile/mailbox.csv', "wb")
    writer = csv.writer(ofile, delimiter=' ', quoting=csv.QUOTE_ALL)
    cursor = connection.cursor()
    cursor.execute("SELECT receiveMessage.receiver,inbox.isread,message.sender,message.sent_date,message.sent_time,receiveMessage.receive_date,message.issue,inbox.messageItem,receiveMessage.receive_time,inbox.inboxItem,message.content,inbox.inbox_from,message.mailbox_sender,receiveMessage.mailbox_receiver,receiveMessage.isread, message.messagekey FROM message,receiveMessage,inbox where inbox.MessageItem = receiveMessage.MessageItem and inbox.messageItem = message.item and (inbox.user=receiveMessage.receiver or inbox.user = message.sender) Group By inbox.inboxItem") # Get data from inbox,receiveMessage and message table
    rows= cursor.fetchall()
    writer.writerow(["Receiver","Is read","Sender","Sent Date","Sent Time","Receive Date","Receive Time","Subject","Content","Message Item","Mailbox Item","Mailbox From","Mailbox Sender","Mailbox Receiver","Is Read by Receiver","Message Key","Mailbox Type"]) # Write titles to csv files
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2],rows[i][3],rows[i][4],rows[i][5],rows[i][8],rows[i][6],str(rows[i][10]),rows[i][7],rows[i][9],rows[i][11],rows[i][12],rows[i][13],rows[i][14],rows[i][15],"inbox"]) # Write data that has been got from tables to csv file
      i=i+1
    cursor.execute("SELECT receiveMessage.receiver, outbox.isread,message.sender,message.sent_date,message.sent_time,receiveMessage.receive_date,message.issue,outbox.messageItem,receiveMessage.receive_time,outbox.outboxItem,message.content,outbox.outbox_from,message.mailbox_sender,receiveMessage.mailbox_receiver,receiveMessage.isread,  message.messagekey FROM message,receiveMessage,outbox where outbox.MessageItem = receiveMessage.MessageItem and outbox.messageItem = message.item and (outbox.user=receiveMessage.receiver or outbox.user = message.sender) Group By outbox.outboxItem") # Get data from outbox,receiveMessage and message table
    rows= cursor.fetchall()
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2],rows[i][3],rows[i][4],rows[i][5],rows[i][8],rows[i][6],str(rows[i][10]),rows[i][7],rows[i][9],rows[i][11],rows[i][12],rows[i][13],rows[i][14],rows[i][15],"outbox"]) # Write data that has been got from tables to csv file
      i=i+1
    cursor.execute("SELECT receiveMessage.receiver, draft.isread,message.sender,message.sent_date,message.sent_time,receiveMessage.receive_date,message.issue,draft.messageId,receiveMessage.receive_time,draft.draftId, message.content,draft.draft_from,message.mailbox_sender,receiveMessage.mailbox_receiver,receiveMessage.isread, message.messagekey FROM message,receiveMessage,draft where draft.messageId =  receiveMessage.MessageItem and draft.messageId = message.item and (draft.user=receiveMessage.receiver or draft.user = message.sender)Group By draft.draftId") # Get data from draft,receiveMessage and message table
    rows= cursor.fetchall()
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2],rows[i][3],rows[i][4],rows[i][5],rows[i][8],rows[i][6],str(rows[i][10]),rows[i][7],rows[i][9],rows[i][11],rows[i][12],rows[i][13],rows[i][14],rows[i][15],"draft"]) # Write data that has been got from tables to csv file
      i=i+1
    cursor = connection.cursor()
    cursor.execute("SELECT receiveMessage.receiver, deleteMessage.isread,message.sender,message.sent_date,message.sent_time,receiveMessage.receive_date,message.issue,deleteMessage.messageItem,receiveMessage.receive_time,deleteMessage.deletedItem, message.content,deleteMessage.delete_from,message.mailbox_sender,receiveMessage.mailbox_receiver,receiveMessage.isread, message.messagekey FROM message,receiveMessage,deleteMessage where deleteMessage.messageItem = receiveMessage.MessageItem and deleteMessage.messageItem = message.item and (deleteMessage.user=receiveMessage.receiver or deleteMessage.user = message.sender) Group By deleteMessage.deletedItem") # Get data from deleteMessage,receiveMessage and message table
    rows= cursor.fetchall()
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2],rows[i][3],rows[i][4],rows[i][5],rows[i][8],rows[i][6],str(rows[i][10]),rows[i][7],rows[i][9],rows[i][11],rows[i][12],rows[i][13],rows[i][14],rows[i][15],"deleted"]) # Write data that has been got from tables to csv file
      i=i+1
    cursor.execute("SELECT receiveMessage.receiver, deletedComplete.isread,message.sender,message.sent_date,message.sent_time,receiveMessage.receive_date,message.issue,deletedComplete.messageItem,receiveMessage.receive_time,deletedComplete.deletedItem, message.content,deletedComplete.deleted_from,message.mailbox_sender,receiveMessage.mailbox_receiver,receiveMessage.isread, message.messagekey FROM message,receiveMessage,deletedComplete where deletedComplete.messageItem = receiveMessage.MessageItem and deletedComplete.messageItem = message.item and (deletedComplete.user=receiveMessage.receiver or deletedComplete.user = message.sender) Group By deletedComplete.deletedItem") # Get data from deleteComplete,receiveMessage and message table
    rows= cursor.fetchall()
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2],rows[i][3],rows[i][4],rows[i][5],rows[i][8],rows[i][6],str(rows[i][10]),rows[i][7],rows[i][9],rows[i][11],rows[i][12],rows[i][13],rows[i][14],rows[i][15],"deletedcompletely"]) # Write data that has been got from tables to csv file
      i=i+1
    cursor.execute("SELECT receiveMessage.receiver, draftToReceiver.isread,message.sender,message.sent_date,message.sent_time,receiveMessage.receive_date,message.issue,draftToReceiver.messageItem,receiveMessage.receive_time,draftToReceiver.item, message.content,draftToReceiver.draft_from,message.mailbox_sender,receiveMessage.mailbox_receiver,receiveMessage.isread, message.messagekey FROM message,receiveMessage,draftToReceiver where draftToReceiver.messageItem = receiveMessage.MessageItem and draftToReceiver.messageItem = message.item and (draftToReceiver.user=receiveMessage.receiver or draftToReceiver.user = message.sender) Group By draftToReceiver.item") # Get data from draftToreceiver,receiveMessage and message table
    rows= cursor.fetchall()
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2],rows[i][3],rows[i][4],rows[i][5],rows[i][8],rows[i][6],str(rows[i][10]),rows[i][7],rows[i][9],rows[i][11],rows[i][12],rows[i][13],rows[i][14],rows[i][15],"drafttoreceiver"]) # Write data that has been got from tables to csv file
      i=i+1
    
    
    ofile.close() # close the file
    return HttpResponseRedirect("/backupfile/mailbox.csv") # enable to dowload mailbox.csv
