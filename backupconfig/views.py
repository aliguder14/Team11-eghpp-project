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
import csv #import functions are related to csv file operations
def index(request):
  if not request.user.is_authenticated() or not request.user.is_superuser:
       return HttpResponseRedirect("/login/")
  else:
    ofile  = open('backupfile/userinfo.csv', "wb")
    writer = csv.writer(ofile, delimiter=' ', quoting=csv.QUOTE_ALL)
    cursor = connection.cursor()
    cursor.execute("Select id,first_name,last_name,email,is_active,is_staff,is_superuser,date_joined from auth_user") # get data from auth_user
    rows= cursor.fetchall()
    writer.writerow(["User Id","First Name","Last Name","E-mail Address","Is Active","Is Staff","Is Superuser","Date Joined"]) # write titles to csv file
    i=0
    while i < len(rows):
      writer.writerow([rows[i][0],rows[i][1],rows[i][2],rows[i][3],rows[i][4],rows[i][5],rows[i][6],rows[i][7]]) # write data that has been got from auth_user
      i=i+1
    ofile.close()
    return HttpResponseRedirect("/backupfile/userinfo.csv") #enable to download userinfo.csv file

