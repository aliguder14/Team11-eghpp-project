#-*- coding:utf-8 -*-
from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.http import Http404
import datetime
from django.db import connection # import functions are related to database connection
from django.shortcuts import render_to_response,get_object_or_404
from django.contrib.auth.models import User #import User Class
def index(request):
    if not request.user.is_authenticated() or not request.user.is_superuser: # check user is authenticated and system administrator
       return HttpResponseRedirect("/login/") # return to login page
    else:
     
      cursor = connection.cursor()
      cursor.execute("SELECT username,first_name,last_name,email,is_superuser,is_staff,id FROM auth_user") # show user information from auth_user table
      rows = cursor.fetchall()
      if request.GET:
        userid = request.GET["id"]
        staff = request.GET["staff"]
        if staff == str("1"):
          u = User.objects.get(id= userid)
          # Deactivate users
          u.is_staff=0
          u.is_active=0
          u.save()
          cursor.execute("SELECT username,first_name,last_name,email,is_superuser,is_staff,id FROM auth_user") # show updated information auth_user table
          rows = cursor.fetchall()
          return render_to_response('enteg1/administrate.html', {'rows': rows}) # enable python files to run with html template in django
        elif staff == str("0"):
          u = User.objects.get(id= userid)
          # Activate users
          u.is_staff=1
          u.is_active=1
          u.save()
          cursor.execute("SELECT username,first_name,last_name,email,is_superuser,is_staff,id FROM auth_user") # show updated information auth_user table
          rows = cursor.fetchall()
          return render_to_response('enteg1/administrate.html', {'rows': rows})
      return render_to_response('enteg1/administrate.html', {'rows': rows})
