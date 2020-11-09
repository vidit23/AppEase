from django.db import models
from datetime import datetime
from django.contrib.auth.models import User

class Info(models.Model):
    id = models.IntegerField(primary_key = True)
    kids_name = models.CharField(max_length=250)
    kids_dob = models.CharField(max_length=250)
    guardian = models.CharField(max_length=250)
    kids_weight = models.IntegerField()
    kids_height = models.IntegerField()
    user_id = models.CharField(User,null=True, default="", max_length=250)
    address = models.CharField(max_length=250)
    # user = models.ForeignKey(User,on_delete=models.CASCADE, related_name = "info",null = True)
    def __str__(self):
        return f"Info('{self.kids_name}', '{self.kids_dob}', '{self.guardian}')"

class AnxietyData(models.Model):
    id = models.IntegerField(primary_key = True)
    time = models.DateTimeField()
    heartbeat = models.CharField(max_length=250)
    bp = models.CharField(max_length=250)
    level = models.CharField(max_length=250)
    location = models.CharField(max_length=250)
    user_id = models.CharField(User,null=True, default="", max_length=250)
    # user = models.ForeignKey(User,on_delete=models.CASCADE, related_name = "anxiety",null = True)
    def __str__(self):
        return f"Records('{self.id}', '{self.time}', '{self.heartbeat}', '{self.bp}', '{self.level}', '{self.location}')"

class Records(models.Model):
    id = models.IntegerField(primary_key = True)
    medical_records = models.CharField(max_length=250)
    physician_name = models.CharField(max_length=250)
    comments = models.CharField(max_length=250)
    user_id = models.CharField(User, default="", max_length=250)
    # user = models.ForeignKey(User,on_delete=models.CASCADE, related_name = "records",null = True)
    def __str__(self):
        return f"Records('{self.physician_name}', '{self.medical_records}')"

