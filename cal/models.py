# cal/models.py
from django.db import models
from django.urls import reverse
from datetime import datetime
from django.utils import timezone
# from django.contrib.auth.models import User
from django.conf import settings
from django.db import models

class Event(models.Model):
    user = models.CharField(max_length=50, blank=True, default='') 
    title = models.TextField()
    description = models.TextField()
    start_date = models.DateField(null=True)
    end_date = models.DateField(null=True)
    user_id = models.ForeignKey('people.People',on_delete=models.CASCADE,null=True)
    policy_id = models.ForeignKey('policy.PolicyList',on_delete=models.CASCADE,null=True)

    @property
    def get_html_url(self):
        url = reverse('cal:event_detail', args=(self.id,))
        return f'<a href="{url}"> {self.title[:30]} </a>'