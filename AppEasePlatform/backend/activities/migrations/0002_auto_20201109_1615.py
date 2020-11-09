# Generated by Django 3.0.6 on 2020-11-09 16:15

import django.contrib.auth.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('activities', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='anxietydata',
            name='user',
        ),
        migrations.RemoveField(
            model_name='info',
            name='user',
        ),
        migrations.RemoveField(
            model_name='records',
            name='user',
        ),
        migrations.AddField(
            model_name='anxietydata',
            name='user_id',
            field=models.CharField(default='', max_length=250, null=True, verbose_name=django.contrib.auth.models.User),
        ),
        migrations.AddField(
            model_name='info',
            name='user_id',
            field=models.CharField(default='', max_length=250, null=True, verbose_name=django.contrib.auth.models.User),
        ),
        migrations.AddField(
            model_name='records',
            name='user_id',
            field=models.CharField(default='', max_length=250, verbose_name=django.contrib.auth.models.User),
        ),
    ]
