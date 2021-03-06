from django.template import Context, loader
from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response
from django.http import Http404
import datetime
from django.contrib.auth.decorators import login_required
from django.db import connection,transaction
def index(request):
    if not request.user.is_authenticated() or not request.user.is_superuser: # you need to login as system administrator
       return HttpResponseRedirect("/login/")
    else:
     fil = open("logged_users.txt") # open txt file
     show = request.GET["show"] # system shows all data or by found username
     if request.POST: # if username has been searched
       fillarr = []
       username = request.POST["username"] # entered username
       for line in fil:
         subarr = str(line).split(" ") # split data in each line
         if subarr[0] == username: #if username has been found
              fillarr.append(subarr)
       num_page=0
       page = request.GET["page"] # get page number from link
       page = int(page)
       num_mes = len(fillarr)
       if num_mes % 12 == 0:
           num_page= num_mes / 12
       else:
           num_page = (num_mes / 12)+1
       page_array = [] #create an array to list page numbers
       i=0
       while i < num_page:
          page_array.append(i+1)
          i=i+1
       fillpagearr = []
       start = (int(page)-1) * 12
       end= start + 12
       if len(fillarr) >= end:
         end = start + 12
       else:
         end = start + (len(fillarr) - ((int(page)-1) * 12))
       j=0
       if page == 0:
         for row in fillarr: # Get all rows from query
            fillpagearr.append(row)
            j = j + 1
       else: # Get maximum 12 rows from query in each page
         for row in fillarr:
            if j >= start and j < end:
               fillpagearr.append(row)
            j = j + 1
       return render_to_response('enteg1/showauthlog.html', {'fillpagearr':fillpagearr,'page':page,'page_array':page_array,'show':show,'username':username,'num_page':num_page}) 
     if show == "byuser":
       fillarr = []
       username = request.GET["username"] # get found username
       for line in fil:
         subarr = str(line).split(" ") # split data in each line
         if subarr[0] == username: #get read only found username
              fillarr.append(subarr)
       num_page=0
       page = request.GET["page"] # get page number from link
       page = int(page)
       num_mes = len(fillarr)
       if num_mes % 12 == 0:
           num_page= num_mes / 12
       else:
           num_page = (num_mes / 12)+1
       page_array = [] #create an array to list page numbers
       i=0
       while i < num_page:
          page_array.append(i+1)
          i=i+1
       fillpagearr = []
       start = (int(page)-1) * 12
       end= start + 12
       if len(fillarr) >= end:
         end = start + 12
       else:
         end = start + (len(fillarr) - ((int(page)-1) * 12))
       j=0
       if page == 0:
         for row in fillarr: # Get all rows from query
            fillpagearr.append(row)
            j = j + 1
       else:
         for row in fillarr: # Get maximum 12 rows from query in each page
            if j >= start and j < end:
               fillpagearr.append(row)
            j = j + 1
       return render_to_response('enteg1/showauthlog.html', {'fillpagearr':fillpagearr,'page':page,'page_array':page_array,'show':show,'username':username,'num_page':num_page})  
     
     elif show == "all":
        fillarr = []
        for line in fil:
          subarr = str(line).split(" ")
          fillarr.append(subarr) 
        num_page=0
        page = request.GET["page"] # get page number from link
        page = int(page)
        num_mes = len(fillarr)
        if num_mes % 12 == 0:
           num_page= num_mes / 12
        else:
           num_page = (num_mes / 12)+1
        page_array = [] #create an array to list page numbers
        i=0
        while i < num_page:
          page_array.append(i+1)
          i=i+1
        fillpagearr = []
        start = (int(page)-1) * 12
        end= start + 12
        if len(fillarr) >= end:
          end = start + 12
        else:
          end = start + (len(fillarr) - ((int(page)-1) * 12))
        j=0
        if page == 0:
         for row in fillarr: # Get all rows from query
            fillpagearr.append(row)
            j = j + 1
        else:
         for row in fillarr: # Get maximum 12 rows from query in each page
            if j >= start and j < end:
               fillpagearr.append(row)
            j = j + 1
          
        return render_to_response('enteg1/showauthlog.html', {'fillpagearr':fillpagearr,'page':page,'page_array':page_array,'show':show,'num_page':num_page})
        
