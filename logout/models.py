from django.db import models

from django.db import models

class Poll1(models.Model):
    question = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')

class Choice1(models.Model):
    poll = models.ForeignKey(Poll1)
    choice = models.CharField(max_length=200)
    votes = models.IntegerField()

class Message(models.Model):
      messageId = models.CharField(max_length=200)
      content =   models.CharField(max_length=1000)
      subject =   models.CharField(max_length=300)
      receiver =  models.CharField(max_length=500)
      sender =    models.CharField(max_length=300)
