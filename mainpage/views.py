from django.shortcuts import render_to_response
def index(request):
    print "index"
    return render_to_response('enteg1/main_page.html',{}) # return the template of the mainpage.html page
