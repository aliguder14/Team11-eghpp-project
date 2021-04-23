from django.template import Context, loader
from django.http import HttpResponse
from django.http import HttpResponse,HttpResponseRedirect
from django.http import Http404
from django.contrib.auth import authenticate,login,logout
from django.db import connection
import datetime

def index(request):
  #request.user.authenticated() = False
  logout(request)
  return HttpResponseRedirect("/login/")

   

