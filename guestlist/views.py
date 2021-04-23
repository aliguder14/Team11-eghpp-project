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
     if request.GET:
      item = request.GET["item"]
      cursor = connection.cursor()
      cursor.execute("Delete From guest where item= '"+item+"'") # delete guest information from guest table
      transaction.commit()
      cursor.execute("SELECT perId,firstname,lastname, item,applyDate,applyTime,status FROM guest") # get guest information from guest table after deleting
      rows = cursor.fetchall()
      return render_to_response('enteg1/guestlist.html', {'rows': rows})
     else:
      cursor = connection.cursor()
      cursor.execute("SELECT perId,firstname,lastname, item,applyDate,applyTime,status FROM guest") # get guest information from guest table
      rows = cursor.fetchall()
      return render_to_response('enteg1/guestlist.html', {'rows': rows})
