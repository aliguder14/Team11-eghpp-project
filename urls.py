from django.conf.urls.defaults import *
from django.conf import settings

urlpatterns = patterns('',
    (r'^',include('eghpp-project.mainpage.urls')),# urlpatterns function includes urls of the files where codes are executed
    (r'^login/', include('eghpp-project.login.urls')),
    (r'^inbox/', include('eghpp-project.inbox.urls')),
    (r'^administrate/', include('eghpp-project.administrate.urls')),
    (r'^activation/', include('eghpp-project.activation.urls')),
    (r'^logout/', include('eghpp-project.logout.urls')),
    (r'^compose/', include('eghpp-project.compose.urls')),
    (r'^mailboxitem/', include('eghpp-project.mailboxitem.urls')),
    (r'^outbox/', include('eghpp-project.outbox.urls')),
    (r'^deleted/', include('eghpp-project.deleted.urls')),
    (r'^draft/', include('eghpp-project.draft.urls')),
    (r'^guestlist/', include('eghpp-project.guestlist.urls')),
    (r'^backupconfig/', include('eghpp-project.backupconfig.urls')),
    (r'^backupuserpass/', include('eghpp-project.backupuserpass.urls')),
    (r'^backupmailbox/', include('eghpp-project.backupmailbox.urls')),
    (r'^mainpage/', include('eghpp-project.mainpage.urls')),
    (r'^changepass/', include('eghpp-project.changepass.urls')),
    (r'^guestrequest/', include('eghpp-project.guestrequest.urls')),
    (r'^guestdetail/', include('eghpp-project.guestdetail.urls')),
    (r'^usercreation/', include('eghpp-project.usercreation.urls')),
    (r'^showmessagelog/', include('eghpp-project.showmessagelog.urls')),
    (r'^showauthlog/', include('eghpp-project.showauthlog.urls')),
    (r'^showlog/', include('eghpp-project.showlog.urls')),
    (r'^restoreconfig/', include('eghpp-project.restoreconfig.urls')),
    (r'^restoreuserpass/', include('eghpp-project.restoreuserpass.urls')),
    (r'^restoremailbox/', include('eghpp-project.restoremailbox.urls')),
    
    (r'^resimler/(?P<path>.*)$', 'django.views.static.serve',
        {'document_root': '/home/ali/eghpp-project/resimler','show_indexes': True}),
    (r'^backupfile/(?P<path>.*)$', 'django.views.static.serve',
        {'document_root': '/home/ali/eghpp-project/backupfile','show_indexes': True}),
    (r'^uploadedfile/(?P<path>.*)$', 'django.views.static.serve',
        {'document_root': '/home/ali/eghpp-project/uploadedfile','show_indexes': True}),

)














