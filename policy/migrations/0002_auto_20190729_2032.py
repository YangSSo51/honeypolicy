# Generated by Django 2.2.3 on 2019-07-29 20:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('policy', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='PolicyList',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('body', models.TextField()),
                ('writer', models.CharField(default='admin', max_length=20)),
                ('pub_date', models.DateTimeField(auto_now=True)),
                ('hits', models.IntegerField(default=0)),
                ('region', models.CharField(choices=[('서울', '서울'), ('인천', '인천'), ('경기', '경기')], max_length=20)),
            ],
            options={
                'ordering': ['-hits'],
            },
        ),
        migrations.DeleteModel(
            name='People',
        ),
    ]