#-*- coding:utf-8 -*-
from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response
from django.http import Http404
import datetime
from django.contrib.auth.decorators import login_required
from django.db import connection,transaction

def index(request):
    if not request.user.is_authenticated():
       return HttpResponseRedirect("/login/")
    else:
       use = request.user.username #get the username of authenticated user
       cursor = connection.cursor() # connect to database
       cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.sent_date,message.issue,message.item,message.sent_time,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item AND draft.user='"+use+"' AND(receiveMessage.mailbox_receiver = 'draft' OR message.mailbox_sender='draft') GROUP By draft.draftId Order By message.sent_date DESC, message.sent_time DESC")  # Get the data from draft,message and receiveMessage table
       rows = cursor.fetchall()
       # these codes are for paginating
       num_page=0
       page = request.GET["page"] # get the page number
       page = int(page)
       num_mes = len(rows)
       if num_mes % 8 == 0:
          num_page= num_mes / 8
       else:
         num_page = (num_mes / 8)+1
       page_array = [] #create an array to list page numbers
       i=0
       while i < num_page:
          page_array.append(i+1)
          i=i+1
       rowspage = []
       start = (int(page)-1) * 8
       end= start + 8
       if len(rows) >= end:
          end = start + 8
       else:
          end = start + (len(rows) - ((int(page)-1) * 8))
       j=0
       if page == 0:
         for row in rows: # Get all from query
           rowspage.append(row)
           j = j + 1
       else:
         for row in rows: # Get maximum 8 rows from query in each page
           if j >= start and j < end:
              rowspage.append(row)
           j = j + 1
       
       if request.POST:
          cursor = connection.cursor()
          if request.POST["action"] == str("Read"): # if user clicks Read button
             for select in request.POST.getlist("select"): # get selected messages by checkboxes
          
                cursor.execute("UPDATE draft set isread='+' where draftId='"+select+"'") # sign selected message as read
                transaction.commit_unless_managed()
             cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.sent_date,message.issue,message.item,message.sent_time,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item AND draft.user='"+use+"' AND(receiveMessage.mailbox_receiver = 'draft' OR message.mailbox_sender='draft') GROUP By draft.draftId Order By message.sent_date DESC, message.sent_time DESC") # Get the updated data from draft,message and receiveMessage table
             rows = cursor.fetchall()
             num_page=0
             num_mes = len(rows)
             if num_mes % 8 == 0:
               num_page= num_mes / 8
             else:
              num_page = (num_mes / 8)+1
             page_array = [] #create an array to list page numbers
             i=0
             while i < num_page:
              page_array.append(i+1)
              i=i+1
             rowspage = []
             start = (int(page)-1) * 8
             end= start + 8
             if len(rows) >= end:
               end = start + 8
             else:
               end = start + (len(rows) - ((int(page)-1) * 8))
             j=0
             if page == 0:
               for row in rows: # Get all from query
                 rowspage.append(row)
                 j = j + 1
             else:
               for row in rows: # Get maximum 8 rows from query in each page
                 if j >= start and j < end:
                   rowspage.append(row)
                 j = j + 1
             return render_to_response('enteg1/draft.html', {'use':use,'rowspage':rowspage,'page':page,'page_array':page_array,'num_page':num_page})
       
          elif request.POST["action"] == str("Delete"): # if user presses Delete button
           for select in request.POST.getlist("select"): # get selected messages by checkboxes
            cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.item,receiveMessage.mailbox_receiver,message.mailbox_sender,draft.draft_from,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item and draft.draftId = '"+select+"'") # get data that are related to selected messages from tables
            row = cursor.fetchall()
            mesg = row[0][2]
            read = row[0][1]
            s = row[0][6]
            box = row[0][5]
            if box == "outbox": # check messages are sent
              cursor.execute("UPDATE message set mailbox_sender='deleted' where item=%s",[mesg]) # set mailbox_sender as deleted in message table
              transaction.commit()
              cursor.execute("INSERT INTO deleteMessage (messageItem,delete_from,user,isread) VALUES (%s,'outbox','"+use+"','"+read+"')",[mesg]) # insert message data from draft to deleteMessage table
              transaction.commit()
            elif box == "inbox": # check messages are received
              cursor.execute("UPDATE receiveMessage set mailbox_receiver='deleted' where MessageItem=%s and receiver= '"+use+"'",[mesg]) # set mailbox_receiver as deleted in recieveMessage table
              transaction.commit()
              cursor.execute("INSERT INTO deleteMessage (messageItem,delete_from,user,isread) VALUES (%s,'inbox','"+use+"','"+read+"')",[mesg])
              transaction.commit()
            cursor.execute("Delete From draft where draftId=%s",[s]) # Delete selected message data from draft
            transaction.commit()

           cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.sent_date,message.issue,message.item,message.sent_time,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item AND draft.user='"+use+"' AND(receiveMessage.mailbox_receiver = 'draft' OR message.mailbox_sender='draft') GROUP By draft.draftId Order By message.sent_date DESC, message.sent_time DESC")
           rows = cursor.fetchall()
           num_page=0
           num_mes = len(rows)
           if num_mes % 8 == 0:
              num_page= num_mes / 8
           else:
             num_page = (num_mes / 8)+1
           page_array = [] #create an array to list page numbers
           i=0
           while i < num_page:
             page_array.append(i+1)
             i=i+1
           rowspage = []
           start = (int(page)-1) * 8
           end= start + 8
           if len(rows) >= end:
             end = start + 8
           else:
              end = start + (len(rows) - ((int(page)-1) * 8))
           j=0
           if page == 0:
               for row in rows: # Get all rows from query
                 rowspage.append(row)
                 j = j + 1
           else:
               for row in rows: # Get maximum 8 rows from query in each page
                 if j >= start and j < end:
                   rowspage.append(row)
                 j = j + 1
           return render_to_response('enteg1/draft.html', {'use':use,'rowspage':rowspage,'page':page,'page_array':page_array,'num_page':num_page})   
          elif request.POST["action"] == str("Unread"): # if user clicks Uread button
           for select in request.POST.getlist("select"):
             cursor.execute("UPDATE draft set isread='-' where draftId='"+select+"'") # uread message
             transaction.commit()
           cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.sent_date,message.issue,message.item,message.sent_time,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item AND draft.user='"+use+"' AND(receiveMessage.mailbox_receiver = 'draft' OR message.mailbox_sender='draft') Order By message.sent_date DESC, message.sent_time DESC")
           rows = cursor.fetchall()
           num_page=0
           num_mes = len(rows)
           if num_mes % 8 == 0:
              num_page= num_mes / 8
           else:
             num_page = (num_mes / 8)+1
           page_array = [] #create an array to list page numbers
           i=0
           while i < num_page:
             page_array.append(i+1)
             i=i+1
           rowspage = []
           start = (int(page)-1) * 8
           end= start + 8
           if len(rows) >= end:
             end = start + 8
           else:
              end = start + (len(rows) - ((int(page)-1) * 8))
           j=0
           if page == 0:
               for row in rows: # Get all rows from query
                 rowspage.append(row)
                 j = j + 1
           else:
               for row in rows: # Get maximum 8 rows from query in each page
                 if j >= start and j < end:
                   rowspage.append(row)
                 j = j + 1
           return render_to_response('enteg1/draft.html', {'use':use,'rowspage':rowspage,'page':page,'page_array':page_array,'num_page':num_page})
          elif request.POST["action"] == str("Move"): # if user clicks on Move button
           if request.POST["mailboxes"] == str("inbox"): # if user select inbox from combo box
            
            for select in request.POST.getlist("select"): # get selected messages by checkboxes
             cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.item,receiveMessage.mailbox_receiver,message.mailbox_sender,draft.draft_from,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item and draft.draftId = '"+select+"'")
             row = cursor.fetchall()
             mesg = row[0][2]
             read = row[0][1]
             s = row[0][6]
             box = row[0][5]
             if box == "outbox": # check messages are sent
              cursor.execute("UPDATE message set mailbox_sender='inbox' where item=%s",[mesg]) # set mailbox_sender as inbox in message table
              transaction.commit()
              cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES (%s,'outbox','"+use+"','"+read+"')",[mesg]) # insert message data from draft to inbox table
              transaction.commit()
             elif box == "inbox": # check messages are received
              cursor.execute("UPDATE receiveMessage set mailbox_receiver='inbox' where MessageItem=%s and receiver= '"+use+"'",[mesg]) # set mailbox_receiver as inbox in recieveMessage table
              transaction.commit()
              cursor.execute("INSERT INTO inbox (messageItem,inbox_from,user,isread) VALUES (%s,'inbox','"+use+"','"+read+"')",[mesg])
              transaction.commit()
             cursor.execute("Delete From draft where draftId=%s",[s]) # Delete selected message data from draft
             transaction.commit()
             
            cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.sent_date,message.issue,message.item,message.sent_time,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item AND draft.user='"+use+"' AND(receiveMessage.mailbox_receiver = 'draft' OR message.mailbox_sender='draft') GROUP By draft.draftId Order By message.sent_date DESC, message.sent_time DESC")
            rows = cursor.fetchall()
            num_page=0
            num_mes = len(rows)
            if num_mes % 8 == 0:
              num_page= num_mes / 8
            else:
             num_page = (num_mes / 8)+1
            page_array = [] #create an array to list page numbers
            i=0
            while i < num_page:
             page_array.append(i+1)
             i=i+1
            rowspage = []
            start = (int(page)-1) * 8
            end= start + 8
            if len(rows) >= end:
             end = start + 8
            else:
              end = start + (len(rows) - ((int(page)-1) * 8))
            j=0
            if page == 0:
               for row in rows: # Get all rows from query
                 rowspage.append(row)
                 j = j + 1
            else:
               for row in rows: # Get maximum 8 rows from query in each page
                 if j >= start and j < end:
                   rowspage.append(row)
                 j = j + 1
            return render_to_response('enteg1/draft.html', {'use':use,'rowspage':rowspage,'page':page,'page_array':page_array,'num_page':num_page})
           elif request.POST["mailboxes"] == str("outbox"): # if user select outbox from combo box
            for select in request.POST.getlist("select"): # get selected messages by checkboxes
             cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.item,receiveMessage.mailbox_receiver,message.mailbox_sender,draft.draft_from,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item and draft.draftId = '"+select+"'")
             row = cursor.fetchall()
             mesg = row[0][2]
             read = row[0][1]
             s = row[0][6]
             box = row[0][5]
             if box == "outbox": # check messages are sent
              cursor.execute("UPDATE message set mailbox_sender='outbox' where item=%s",[mesg]) # set mailbox_sender as outbox in message table
              transaction.commit()
              cursor.execute("INSERT INTO outbox (messageItem,outbox_from,user,isread) VALUES (%s,'outbox','"+use+"','"+read+"')",[mesg]) # insert message data from draft to outbox table
              transaction.commit()
             elif box == "inbox": # check messages are received
              cursor.execute("UPDATE receiveMessage set mailbox_receiver='outbox' where MessageItem=%s and receiver= '"+use+"'",[mesg]) # set mailbox_receiver as outbox in recieveMessage table
              transaction.commit()
              cursor.execute("INSERT INTO outbox (messageItem,outbox_from,user,isread) VALUES (%s,'inbox','"+use+"','"+read+"')",[mesg])
              transaction.commit()
             cursor.execute("Delete From draft where draftId=%s",[s]) # Delete selected message data from draft
             transaction.commit()

            cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.sent_date,message.issue,message.item,message.sent_time,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item AND draft.user='"+use+"' AND(receiveMessage.mailbox_receiver = 'draft' OR message.mailbox_sender='draft') GROUP By draft.draftId Order By message.sent_date DESC, message.sent_time DESC")
            rows = cursor.fetchall()
            num_page=0
            num_mes = len(rows)
            if num_mes % 8 == 0:
              num_page= num_mes / 8
            else:
             num_page = (num_mes / 8)+1
            page_array = [] #create an array to list page numbers
            i=0
            while i < num_page:
             page_array.append(i+1)
             i=i+1
            rowspage = []
            start = (int(page)-1) * 8
            end= start + 8
            if len(rows) >= end:
             end = start + 8
            else:
              end = start + (len(rows) - ((int(page)-1) * 8))
            j=0
            if page == 0:
               for row in rows: # Get all rows from query
                 rowspage.append(row)
                 j = j + 1
            else:
               for row in rows: # Get maximum 8 rows from query in each page
                 if j >= start and j < end:
                   rowspage.append(row)
                 j = j + 1
            return render_to_response('enteg1/draft.html', {'use':use,'rowspage':rowspage,'page':page,'page_array':page_array,'num_page':num_page})
           elif request.POST["mailboxes"] == str("deleted"): # if user select trash from combo box
            for select in request.POST.getlist("select"):
             cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.item,receiveMessage.mailbox_receiver,message.mailbox_sender,draft.draft_from,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item and draft.draftId = '"+select+"'")
             row = cursor.fetchall()
             mesg = row[0][2]
             read = row[0][1]
             s = row[0][6]
             box = row[0][5]
             if box == "outbox": # check messages are sent
              cursor.execute("UPDATE message set mailbox_sender='deleted' where item=%s",[mesg]) # set mailbox_sender as deleted in message table
              transaction.commit()
              cursor.execute("INSERT INTO deleteMessage (messageItem,delete_from,user,isread) VALUES (%s,'outbox','"+use+"','"+read+"')",[mesg]) # insert message data from draft to deleteMessage table
              transaction.commit()
             elif box == "inbox": # check messages are received
              cursor.execute("UPDATE receiveMessage set mailbox_receiver='deleted' where MessageItem=%s and receiver= '"+use+"'",[mesg]) # set mailbox_receiver as deleted in recieveMessage table
              transaction.commit()
              cursor.execute("INSERT INTO deleteMessage (messageItem,delete_from,user,isread) VALUES (%s,'inbox','"+use+"','"+read+"')",[mesg])
              transaction.commit()
             cursor.execute("Delete From draft where draftId=%s",[s]) # Delete selected message data from draft
             transaction.commit()

            cursor.execute("SELECT receiveMessage.receiver,draft.isread,message.sent_date,message.issue,message.item,message.sent_time,draft.draftId FROM message,receiveMessage,draft where message.item  = receiveMessage.MessageItem and draft.messageId = message.item AND draft.user='"+use+"' AND (receiveMessage.mailbox_receiver = 'draft' OR message.mailbox_sender='draft') GROUP By draft.draftId Order By message.sent_date DESC, message.sent_time DESC")
            rows = cursor.fetchall()
            num_page=0
            num_mes = len(rows)
            if num_mes % 8 == 0:
              num_page= num_mes / 8
            else:
             num_page = (num_mes / 8)+1
            page_array = [] #create an array to list page numbers
            i=0
            while i < num_page:
             page_array.append(i+1)
             i=i+1
            rowspage = []
            start = (int(page)-1) * 8
            end= start + 8
            if len(rows) >= end:
             end = start + 8
            else:
              end = start + (len(rows) - ((int(page)-1) * 8))
            j=0
            if page == 0:
               for row in rows: # Get all rows from query
                 rowspage.append(row)
                 j = j + 1
            else:
               for row in rows: # Get 8 rows from query in each page
                 if j >= start and j < end:
                   rowspage.append(row)
                 j = j + 1
            return render_to_response('enteg1/draft.html', {'use':use,'rowspage':rowspage,'page':page,'page_array':page_array,'num_page':num_page})
       return render_to_response('enteg1/draft.html', {'use':use,'rowspage':rowspage,'page':page,'page_array':page_array,'num_page':num_page})
