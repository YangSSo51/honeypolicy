# cal/models.py
from django.db import models
from django.urls import reverse
from datetime import datetime
from django.utils import timezone
# from django.contrib.auth.models import User
from django.conf import settings
from django.db import models

class Event(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    start_date = models.DateField()
    end_date = models.DateField()
    @property
    def get_html_url(self):
        url = reverse('cal:event_edit', args=(self.id,))
        return f'<a href="{url}"> {self.title} </a>'