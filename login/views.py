from django.template import Context, loader
from django.http import HttpResponse
from django.http import HttpResponse,HttpResponseRedirect
from django.http import Http404
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.db import connection,transaction
import datetime
from django.shortcuts import render_to_response
def index(request):
  if request.method == 'POST':
      username = request.POST['user'] # get entered username from form
      password = request.POST['pass'] # get entered password from form
      user = authenticate(username=username, password=password) # authenticate user
      if user is not None: # check whether this user is registered in the system 
         if user.is_active: # check whether this user is active in the system
            login(request,user)
            us = user.username
            em = user.email
            cursor = connection.cursor()
            cursor.execute("Update auth_user set last_login=NOW() where username='"+us+"'") # set the last login date to current date
            transaction.commit()
            cursor.execute("Select last_login From auth_user where username='"+us+"'")
            row = cursor.fetchall()
            last = row[0][0]
            logfile = open("logged_users.txt", "a") # write data that is related to authentication to log file 
            logfile.write(us+" "+em+" "+str(last)+"\n")
            logfile.close()
            
            if user.is_superuser:
                 return HttpResponseRedirect("/administrate/") # if user is admin, redirect to admin page
            elif not user.is_superuser: 
                 return HttpResponseRedirect("/inbox/?page=1") # if user is normal user, redirect user inbox page
         else:
            sentence = "*Your account has not been activated" # warining sentence
            return render_to_response('enteg1/user_login_page.html',{'sentence':sentence})
      else:
        sentence = "*You are not registered in the system" # warining sentence
        return render_to_response('enteg1/user_login_page.html',{'sentence':sentence})
  else:
    return render_to_response('enteg1/user_login_page.html',{})



