from django.db import models

# Create your models here.
# class Child(models.Model):
#     name = models.CharField(max_length=250, blank=False)
#     age = models.IntegerField()
#     owner = models.ForeignKey('auth.user', related_name='posts', on_delete=models.CASCADE)

#     # created = models.DateTimeField(auto_now_add=True)
#     # title = models.CharField(max_length=100, blank=False)
#     # content = models.TextField()
#     # author = models.CharField(max_length=100, blank=False)
#     # owner = models.ForeignKey('auth.user', related_name='posts', on_delete=models.CASCADE)

#     class Meta:
#         ordering = ['created']


class healthData(models.Model):
    # userToken = models.CharField(max_length=250, blank=False)
    # timeStamp = models.DateTimeField()

    # heartRate = models.IntegerField()
    # stepsCount = models.IntegerField()

    # stationaryLabelCount = models.IntegerField()
    # walkingLabelCount = models.IntegerField()
    # runningLabelCount = models.IntegerField()
    # automotiveLabelCount = models.IntegerField()
    # cyclingLabelCount = models.IntegerField()
    # unknownLabelCount = models.IntegerField()
    # distanceCovered = models.FloatField()

    # age = models.IntegerField()
    # sex = models.CharField(max_length=250,blank = False)
    # bloodType = models.CharField(max_length=250, blank = False)

    timestamp = models.TextField(db_column='timeStamp', blank=True, null=True)  # Field name made lowercase.
    usertoken = models.TextField(db_column='userToken', blank=True, null=True)  # Field name made lowercase.
    age = models.IntegerField(blank=True, null=True)
    sex = models.TextField(blank=True, null=True)
    bloodtype = models.TextField(db_column='bloodType', blank=True, null=True)  # Field name made lowercase.
    heartrate = models.IntegerField(db_column='heartRate', blank=True, null=True)  # Field name made lowercase.
    stepscount = models.IntegerField(db_column='stepsCount', blank=True, null=True)  # Field name made lowercase.
    distancecovered = models.FloatField(db_column='distanceCovered', blank=True, null=True)  # Field name made lowercase.
    stationarylabelcount = models.IntegerField(db_column='stationaryLabelCount', blank=True, null=True)  # Field name made lowercase.
    walkinglabelcount = models.IntegerField(db_column='walkingLabelCount', blank=True, null=True)  # Field name made lowercase.
    runninglabelcount = models.IntegerField(db_column='runningLabelCount', blank=True, null=True)  # Field name made lowercase.
    automotivelabelcount = models.IntegerField(db_column='automotiveLabelCount', blank=True, null=True)  # Field name made lowercase.
    cyclinglabelcount = models.IntegerField(db_column='cyclingLabelCount', blank=True, null=True)  # Field name made lowercase.
    unknownlabelcount = models.IntegerField(db_column='unknownLabelCount', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        # ordering = ["userToken", "timeStamp"]
        db_table = 'healthData'
    



# CREATE TABLE healthData_new (
# id integer primary key autoincrement, timeStamp text, userToken text, age integer, sex text, bloodType text,
# heartRate integer, stepsCount integer, distanceCovered real,
# stationaryLabelCount integer, walkingLabelCount integer,
# runningLabelCount integer, automotiveLabelCount integer,
# cyclingLabelCount integer, unknownLabelCount integer);


# INSERT INTO healthData_new(timeStamp, userToken, age, sex, bloodType,
# heartRate, stepsCount, distanceCovered,
# stationaryLabelCount, walkingLabelCount ,
# runningLabelCount , automotiveLabelCount ,
# cyclingLabelCount , unknownLabelCount )
# SELECT timeStamp, userToken, age, sex, bloodType,
# heartRate, stepsCount, distanceCovered,
# stationaryLabelCount, walkingLabelCount ,
# runningLabelCount , automotiveLabelCount ,
# cyclingLabelCount , unknownLabelCount
# FROM healthData;

# | 1,"2020-12-07T06:54:50Z","de83f26f38e4c6eb7dfc8619bad9f37954980b37", 25,"Male","B+",112,9,0.00355675197751603,0,0,0,0,0,0


# INSERT INTO healthData(timeStamp, userToken, age, sex, bloodType,
#    heartRate, stepsCount, distanceCovered,
#    stationaryLabelCount, walkingLabelCount ,
#    runningLabelCount , automotiveLabelCount ,
#    cyclingLabelCount , unknownLabelCount )
#    VALUES("2020-12-07T08:11:70Z","3a6f4a45512afe7764b285fd841d026bf418153d", 25,"Male","B+",120,9,0.00355675197751603,0,0,0,0,0,0)
