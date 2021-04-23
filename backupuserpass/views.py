from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response
from django.http import Http404
import datetime
from django.contrib.auth.decorators import login_required
import cgitb; cgitb.enable()
from django import forms
import cgi, os
from django.db import connection,transaction # import functions for database operations
from django.conf import settings
import csv # import functions for csv file operations
def index(request):
  if not request.user.is_authenticated() or not request.user.is_superuser: # you need to login as system administrator
       return HttpResponseRedirect("/login/")
  else:
    ofile  = open('backupfile/userpass.csv', "wb") # open csv file in write mode
    writer = csv.writer(ofile, delimiter=' ', quoting=csv.QUOTE_ALL)
    cursor = connection.cursor()
    cursor.execute("Select id,username,password from auth_user") # get id,username and password information from auth_user table
    writer.writerow(["Id","Username","Password"]) # Write titles to csv page
    rows= cursor.fetchall()
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2]]) # Write data that has been got from auth_user table
      i=i+1
    ofile.close()
    return HttpResponseRedirect("/backupfile/userpass.csv")
