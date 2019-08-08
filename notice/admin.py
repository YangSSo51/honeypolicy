from django.contrib import admin
from .models import Notice
from cal.models import Event

# Register your models here.

admin.site.register(Notice)
admin.site.register(Event)
