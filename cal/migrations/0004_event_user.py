# Generated by Django 2.2.3 on 2019-08-09 22:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cal', '0003_auto_20190809_2140'),
    ]

    operations = [
        migrations.AddField(
            model_name='event',
            name='user',
            field=models.CharField(blank=True, default='', max_length=50),
        ),
    ]
