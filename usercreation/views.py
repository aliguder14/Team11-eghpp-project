from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.http import Http404
import datetime
from django.db import connection,transaction
from django.shortcuts import render_to_response,get_object_or_404
from django.contrib.auth.models import User
def index(request):
    if not request.user.is_authenticated() or not request.user.is_superuser:
       return HttpResponseRedirect("/login/")
    else:
       if request.POST:
         Firstname = request.POST["firstname"] 
         user = request.POST["user"]
         Lastname = request.POST["lastname"]
         email = request.POST["email"]
         password = request.POST["pass"]
         passagain = request.POST["passagain"]
         isstaff = request.POST.getlist("isstaff")
         isactive = request.POST.getlist("isactive")
         if Firstname.strip() == "" or Lastname.strip() == "" or user.strip() == "" or email.strip() == "" or password.strip() == "" or passagain.strip() == "": # check all fields are filled or not
           sentence = "*please fill the form" 
           return render_to_response('enteg1/usercreation.html', {'sentence':sentence})
         else:
           if password != passagain:
              sentence = "Passwords cannot be matched"
              return render_to_response('enteg1/usercreation.html', {'sentence':sentence})
           else:
             # Create User
             if len(isstaff) > 0:
              is_staff = True
             else:
              is_staff = False
             if len(isactive) > 0:
                is_active = True
             else:
               is_active = False
             user = User.objects.create_user(user.strip(), email.strip(), password)
             user.first_name = Firstname.strip()
             user.save()
             user.last_name = Lastname.strip()
             user.save()
             user.is_active = is_active
             user.save()
             user.is_staff = is_staff
             user.save()
             sentence = "User is created successfully"
             # After username and password is created, username and password is sent to new user with closed envelope
             return render_to_response('enteg1/usercreation.html', {'sentence':sentence})
       else:
        sentence = ""      
        return render_to_response('enteg1/usercreation.html', {'sentence':sentence})
