from django.db import models
from django.contrib.auth.models import AbstractUser

class People(AbstractUser):
    gender = models.CharField(max_length=15, blank=True)
    birth = models.DateField(null=True, blank=True)
    phone = models.CharField(max_length=20)
