# Generated by Django 2.2.3 on 2019-08-09 00:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cal', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='event',
            name='end_time',
        ),
        migrations.RemoveField(
            model_name='event',
            name='start_time',
        ),
        migrations.AddField(
            model_name='event',
            name='end_date',
            field=models.DateField(null=True),
        ),
        migrations.AddField(
            model_name='event',
            name='start_date',
            field=models.DateField(null=True),
        ),
        migrations.AddField(
            model_name='event',
            name='user',
            field=models.CharField(blank=True, default='', max_length=15),
        ),
    ]
