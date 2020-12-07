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
    userToken = models.CharField(max_length=250, blank=False)
    timeStamp = models.DateTimeField()

    heartRate = models.IntegerField()
    stepsCount = models.IntegerField()

    stationaryLabelCount = models.IntegerField()
    walkingLabelCount = models.IntegerField()
    runningLabelCount = models.IntegerField()
    automotiveLabelCount = models.IntegerField()
    cyclingLabelCount = models.IntegerField()
    unknownLabelCount = models.IntegerField()
    distanceCovered = models.FloatField()

    class Meta:
        ordering = ["userToken", "timeStamp"]
    