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
 if not request.user.is_authenticated() or not request.user.is_superuser: # you need to login as system administrator
       return HttpResponseRedirect("/login/")
 else:
  try:
   ofile  = open('backupfile/userinfo.csv')
   reader = csv.reader(ofile, delimiter=' ') # open file in read mode
   cursor = connection.cursor() # connect to databae
   j=0
   for row in reader:
     i=0
     if j != 0: # check whethet row consists of titles
        cursor.execute("Select id,first_name,last_name,email,is_active,is_staff,is_superuser,date_joined From auth_user where id=%s",[row[0]])
        ro = cursor.fetchall()
        count=0
        for r in ro:
          count = count+1
        if count > 0: # check whether this user id exists in auth_user table or not
           if row[1] != ro[0][1]:
             cursor.execute("Update auth_user set first_name='"+row[1]+"' where id = %s",[row[0]]) # if firstname is null, fill the firstname
             transaction.commit()
           if row[2] != ro[0][2]:
              cursor.execute("Update auth_user set last_name='"+row[2]+"' where id = %s",[row[0]]) # if lastname is null, fill the lastname
              transaction.commit()
           if row[3] != ro[0][3]:
             cursor.execute("Update auth_user set email='"+row[3]+"' where id = %s",[row[0]]) # if email is null, fill the email
             transaction.commit()
           if row[4] != ro[0][4]:
              cursor.execute("Update auth_user set is_active=%s where id = %s",[row[4],row[0]]) # if is_active is null, fill the is_active
              transaction.commit()
           if row[5] != ro[0][5]:
              cursor.execute("Update auth_user set is_staff=%s where id = %s",[row[5],row[0]]) # if is_staff is null, fill the is_staff
              transaction.commit()
           if row[6] != ro[0][6]:
             cursor.execute("Update auth_user set is_superuser=%s where id = %s",[row[6],row[0]]) # if is_superuser is null, fill the superuser
             transaction.commit()
           if row[7] != ro[0][7]:
             cursor.execute("Update auth_user set date_joined=%s where id = %s",[row[7],row[0]]) # if date_joined is null, fill the date_joined
             transaction.commit()
        else:
          cursor.execute("INSERT INTO auth_user (id,first_name,last_name,email,is_active,is_staff,is_superuser,date_joined) VALUES (%s,'"+row[1]+"','"+row[2]+"','"+row[3]+"',%s,%s,%s,%s)",[row[0],row[4],row[5],row[6],row[7]]) # insert data that has been got from userinfo.csv 
          transaction.commit() 
     j=j+1
   ofile.close() # close the file
   sentence = "Data have been restored sucessfully"
   return render_to_response("enteg1/restore.html",{'sentence':sentence})
  except IOError: # file cannot be found
   sentence = "File is not found"
   return render_to_response("enteg1/restore.html",{'sentence':sentence})
   

   

