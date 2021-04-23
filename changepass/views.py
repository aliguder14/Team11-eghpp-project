from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response
from django.http import Http404
import datetime
from django.contrib.auth.decorators import login_required
import MySQLdb
from django.db import connection,transaction
from django.contrib.auth.models import User
def index(request):
   if not request.user.is_authenticated():
       return HttpResponseRedirect("/login/")
   else:
       use = request.user
       rec = request.user.email
       if request.POST:
        oldpass = request.POST["oldpass"] # Get entered old password
        newpass = request.POST["newpass"] # Get entered new password
        newpassagain = request.POST["newpassagain"]
        if use.check_password(oldpass) == True and newpass == newpassagain: # if old password is correct and if new password combinations are the same
           use.set_password(newpass) # change password
           use.save() # save changes
           sentence = "Your password has succesfully changed"
           return render_to_response('enteg1/change_pass.html', {'sentence':sentence}) # return the html template of changeapass.html
        else:
          if not use.check_password(oldpass): # old password is wrong
            sentence = "*Your old password is wrong"
            return render_to_response('enteg1/change_pass.html', {'sentence':sentence})
          if newpass != newpassagain: 
            sentence = "*Your new password combination are not same" # if new password combinations are not the same
            return render_to_response('enteg1/change_pass.html', {'sentence':sentence}) # return the html template of changeapass.html
       else:
         sentence =""
         return render_to_response('enteg1/change_pass.html', {'sentence':sentence}) # return the html template of changeapass.html
