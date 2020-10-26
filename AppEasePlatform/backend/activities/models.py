from django.db import models

# Create your models here.
class Homepage(models.Model):
    homepage_title = models.CharField(max_length=200)
    homepage_content = models.TextField()
    homepage_published = models.DateTimeField('date published')

    def __str__(self):
        return self.homepage_title