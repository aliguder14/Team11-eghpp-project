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
   ofile  = open('backupfile/userpass.csv')
   reader = csv.reader(ofile, delimiter=' ') # open file in read mode
   cursor = connection.cursor() # connect to database
   j=0
   for row in reader:
   
     if j != 0: # check whethet row consists of titles
       cursor.execute("Select id, username ,password From auth_user where id = %s",[row[0]])
       ro = cursor.fetchall()
       count = 0
       for r in ro:
         count = count+1
       if count > 0: # check whether this user id exists in auth_user table or not
         if row[1] != ro[0][1]:
            cursor.execute("Update auth_user set username='"+row[1]+"' where id = %s",[row[0]]) # if username is null, fill the username
            transaction.commit()
         if row[2] != ro[0][2]:
            cursor.execute("Update auth_user set password='"+row[2]+"' where id = %s",[row[0]]) # if password is null, fill the password
            transaction.commit()
       else:
        cursor.execute("INSERT INTO auth_user (id,username,password) VALUES (%s,'"+row[1]+"','"+row[2]+"')",[row[0]]) # insert data that has been got from userpass.csv
        transaction.commit()
              
     j=j+1 # increment j by 1
   ofile.close() # close the file
   sentence = "Data have been restored sucessfully"
   return render_to_response("enteg1/restore.html",{'sentence':sentence})
  except IOError: # file cannot be found
   sentence = "File is not found"
   return render_to_response("enteg1/restore.html",{'sentence':sentence})
