#-*- coding:utf-8 -*-
from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.http import Http404
import datetime
from django.db import connection,transaction
from django.shortcuts import render_to_response,get_object_or_404
from django.contrib.auth.models import User
from datetime import date

def DateFormat(date): # show months in letter format
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
def showWeekDay(dates): # show weekdays in letter format
   dates = dates.split("-")
   year = int(dates[0])
   month = int(dates[1])
   day =  int(dates[2])
   eventDate = date(year,month,day)
   dayofWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
   weekDay = dayofWeek[date.weekday(eventDate)]
   return weekDay
def index(request):
    if not request.user.is_authenticated() or not request.user.is_superuser:
       return HttpResponseRedirect("/login/")
    else:
      
      action = request.GET["action"]
      item = request.GET["item"]
      sentence = ""
      if action == "view": # enable to view guest information in detail
       cursor = connection.cursor()
       cursor.execute("SELECT perId,firstname,lastname, item,applyDate,applyTime,insNum,taxNum,country,phoneNum,email,status FROM guest where item = '"+item+"'") # get selected guest information
       rows = cursor.fetchall()
       sentence=""
       weekday= showWeekDay(str(rows[0][4]))
       date = DateFormat(str(rows[0][4]))
       return render_to_response('enteg1/guestdetail.html', {'rows': rows,'sentence':sentence,'date':date,'weekday':weekday})
      elif action == "check": # check guest is employee in the company or not
       cursor = connection.cursor()
       cursor.execute("SELECT perId,firstname,lastname, item,applyDate,applyTime,insNum,taxNum,country,phoneNum,email,status FROM guest where item = '"+item+"'")  
       rows = cursor.fetchall()
       cursor.execute("SELECT perId,firstname,lastname,insNum,taxNum,country,phoneNum,email FROM employee where perId =%s and firstname ='"+rows[0][1]+"' and lastname ='"+rows[0][2]+"' and insNum= %s and taxNum= %s and country ='"+rows[0][8]+"'and phoneNum ='"+rows[0][9]+"' and email ='"+rows[0][10]+"'",[rows[0][0],rows[0][6],rows[0][7]]) # get the information of the guest that is employee in the company
       count=0
       ro = cursor.fetchall()
       for r in ro:
         count = count+1
       if count == 0: # if guest is not employee in the company
         sentence = "This employee is not company's worker"
         weekday= showWeekDay(str(rows[0][4]))
         date = DateFormat(str(rows[0][4]))
         return render_to_response('enteg1/guestdetail.html', {'rows': rows,'sentence':sentence,'date':date,'weekday':weekday})
       else: # if guest is employee in the company
         sentence = "This user can be accepted"
         weekday= showWeekDay(str(rows[0][4]))
         date = DateFormat(str(rows[0][4]))
         return render_to_response('enteg1/guestdetail.html', {'rows': rows,'sentence':sentence,'date':date,'weekday':weekday})
      elif action == "disapprove":
       cursor = connection.cursor()
       cursor.execute("UPDATE guest set status = 'disapproved' where item = '"+item+"'") # disapprove the request
       transaction.commit()
       cursor.execute("SELECT perId,firstname,lastname, item,applyDate,applyTime,insNum,taxNum,country,phoneNum,email,status FROM guest where item = '"+item+"'")
       rows = cursor.fetchall()
       return HttpResponseRedirect("/guestlist/")
      elif action == "approve":
       cursor = connection.cursor()
       cursor.execute("UPDATE guest set status = 'approved' where item = '"+item+"'") # approve the request
       transaction.commit()
       cursor.execute("SELECT perId,firstname,lastname, item,applyDate,applyTime,insNum,taxNum,country,phoneNum,email,status FROM guest where item = '"+item+"'")
       rows = cursor.fetchall()
       return HttpResponseRedirect("/usercreation/") # redirect to usercreation page
    
      
