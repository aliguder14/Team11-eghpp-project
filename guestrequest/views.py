#-*- coding:utf-8 -*-
from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response
from django.http import Http404
import datetime
from django.contrib.auth.decorators import login_required
from django.db import connection,transaction
def NotLetter(s): # Check Id Numbers or phone numbers contain digits
    ok=0
    i=0
    while i < len(s):
      j=0
      flag=0
      while j <= 9:
        if s[i] == str(j):
           flag = 1
        j= j + 1
      if flag == 1:
         ok = ok +1
      i = i +1
    if ok == len(s):
       return 1
    else: 
       return 0
   
def ContainAt(s): # Check Email address contain one @ or point
  count_at=0
  count_point=0
  for ch in s:
    if ch == "@":
      count_at = count_at+1
    if ch == ".":
      count_point = count_point+1
  if count_at == 0 or count_at > 1 or count_point == 0:
    return 0
  else: 
    return 1
          

def IsDuplicateTcNo(Id): # check TcNo is duplicated or not
   cursor = connection.cursor()
   cursor.execute("Select * From guest where perId = %s",[Id])
   rows = cursor.fetchall()
   count=0
   for row in rows:
     count = count + 1
   if count == 0:
      return 0
   else:
     return 1
def IsDuplicateInsNum(Id): # check InsNum is duplicated or not
   cursor = connection.cursor()
   cursor.execute("Select * From guest where insNum = %s",[Id])
   rows = cursor.fetchall()
   count=0
   for row in rows:
     count = count + 1
   if count == 0:
      return 0
   else:
     return 1
def IsDuplicateTaxNum(Id): # check TaxNum is duplicated or not
   cursor = connection.cursor()
   cursor.execute("Select * From guest where taxNum = %s",[Id])
   rows = cursor.fetchall()
   count=0
   for row in rows:
     count = count + 1
   if count == 0:
      return 0
   else:
     return 1

def index(request):
    if request.POST:
      firstname = request.POST["name"] # get entered name from form
      lastname = request.POST["surname"] # "" ""     ""   ""   ""
      tcno = request.POST["tcno"] # "" ""     ""   ""   ""
      insurance = request.POST["insurance"] # "" ""     ""   ""   ""
      taxno = request.POST["taxno"] # "" ""     ""   ""   ""
      country = request.POST["country"] # "" ""     ""   ""   ""
      phone = request.POST["phone"] # "" ""     ""   ""   ""
      email = request.POST["email"] # "" ""     ""   ""   ""
      reading = request.POST.getlist("reading")  
      if firstname.strip() == "" or lastname.strip() == "" or tcno.strip() == "" or insurance.strip() == "" or taxno.strip() == ""  or country.strip() == "" or phone.strip() == "" or email.strip() == "": # check whether all lines has been filled or not
        sentence = "*Please fill the all line" 
        return render_to_response('enteg1/guest_request.html',{'sentence':sentence,'firstname':firstname,'lastname':lastname,'tcno':tcno,'insurance':insurance,'taxno':taxno,'country':country,'phone':phone,'email':email})
      else:
          if len(reading) > 0: # check whether term of use has been read or not
           sentence = ""
           cursor = connection.cursor()
           if NotLetter(tcno.strip()) == 1 and NotLetter(insurance.strip()) == 1 and NotLetter(taxno.strip()) == 1 and ContainAt(email.strip()) == 1 and NotLetter(phone.strip()) == 1 and IsDuplicateTcNo(tcno.strip()) == 0 and IsDuplicateInsNum(insurance.strip()) == 0 and IsDuplicateTaxNum(taxno.strip()) == 0:
             cursor.execute("INSERT INTO guest (perId,firstname,lastname,insNum,taxNum,phoneNum,country,applyDate,applyTime,email,status) VALUES('"+tcno+"','"+firstname+"','"+lastname+"','"+insurance+"','"+taxno+"','"+phone+"','"+country+"',CURDATE(),CURTIME(),'"+email+"','waiting')") # insert guest information to guest table
             transaction.commit()
             return render_to_response('enteg1/guest_redirect.html',{}) # return the template of the guest_redirect page
           else:
              tc=""
              ins=""
              tax=""
              em = ""
              ph=""
              tcdub = ""
              insdub = ""
              taxdub = ""
              tcmaxerror = ""
              insmaxerror = ""
              taxmaxerror = ""
              if NotLetter(tcno.strip()) == 0 or NotLetter(insurance.strip()) == 0 or NotLetter(taxno.strip()) == 0 or ContainAt(email.strip()) == 0 or NotLetter(phone.strip()) == 0: # check whether fields has been filled in correct format or not
               
               if NotLetter(tcno.strip()) == 0:
                  tc = "error"
                  sentence = "*Please fill all lines in correct format"
               if NotLetter(insurance.strip()) == 0:
                 ins = "error"
                 sentence = "*Please fill all lines in correct format" 
               if NotLetter(taxno.strip()) == 0:
                 tax = "error"
                 sentence = "*Please fill all lines in correct format"
               if ContainAt(email.strip()) == 0:
                  em = "error"
                  sentence = "*Please fill all lines in correct format"
               if NotLetter(phone.strip()) == 0:
                  ph = "error"
                  sentence = "*Please fill all lines in correct format"
               
               return render_to_response('enteg1/guest_request.html',{'sentence':sentence,'firstname':firstname,'lastname':lastname,'tcno':tcno,'insurance':insurance,'taxno':taxno,'country':country,'phone':phone,'email':email,'tax':tax,'tc':tc,'ins':ins,
'em':em,'ph':ph,'tcdub':tcdub,'insdub':insdub,'taxdub':taxdub})
              elif IsDuplicateTcNo(tcno.strip()) == 1 or IsDuplicateInsNum(insurance.strip()) == 1 or IsDuplicateTaxNum(taxno.strip()) == 1: # Check whether data that is related to Id numbers are duplicated or not
               if IsDuplicateTcNo(tcno.strip()) == 1:
                  tcdub = "error"
                  sentence = "*T.C Numbers must be unique"
               elif IsDuplicateInsNum(insurance.strip()) == 1:
                  insdub = "error"
                  sentence = "*Insurance Numbers must be unique"
               elif IsDuplicateTaxNum(taxno.strip()) == 1:
                  taxdub = "error"
                  sentence = "*Tax Numbers must be unique"
              
               return render_to_response('enteg1/guest_request.html',{'sentence':sentence,'firstname':firstname,'lastname':lastname,'tcno':tcno,'insurance':insurance,'taxno':taxno,'country':country,'phone':phone,'email':email,'tax':tax,'tc':tc,'ins':ins,
'em':em,'ph':ph,'tcdub':tcdub,'insdub':insdub,'taxdub':taxdub})
          else:
           sentence = "*Please read the agreement"
           return render_to_response('enteg1/guest_request.html',{'sentence':sentence,'firstname':firstname,'lastname':lastname,'tcno':tcno,'insurance':insurance,'taxno':taxno,'country':country,'phone':phone,'email':email})
        
    else:
       sentence = ""
       return render_to_response('enteg1/guest_request.html',{'sentence':sentence})
