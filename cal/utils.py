from datetime import datetime, timedelta
from calendar import HTMLCalendar, month_name, _localized_day
from .models import Event


class Calendar(HTMLCalendar):
   def __init__(self, year=None, month=None):
      self.year = year
      self.month = month
      super(Calendar, self).__init__()

   # formats a day as a td
   # filter events by day
   def formatday(self, day, events):
      events_per_day = events.filter(start_date__day=day)
      d = ''

      for event in events_per_day:
        d += f'<li> {event.get_html_url}</li>' 

      if day != 0:
         if datetime.today().day == day and datetime.today().month == self.month and datetime.today().year == self.year:
            return f"<td><span class='today'>{day}</span><ul> {d} </ul></td>"
         else:
            return f"<td><span class='date'>{day}</span><ul> {d} </ul></td>"
      return '<td></td>'

   # formats a week as a tr
   def formatweek(self, theweek, events):
      week = ''
      for d, weekday in theweek:
         week += self.formatday(d, events)
      return f'<tr> {week} </tr>'


   def formatmonth(self, withyear=True):
      events = Event.objects.filter(start_date__year=self.year, start_date__month=self.month)

      cal = f'<table border="0" cellpadding="0" cellspacing="0" class="calendar">\n'
      cal += f'{self.formatmonthname(self.year, self.month, withyear=withyear)}\n'
      cal += f'{self.formatweekheader()}\n'
      for week in self.monthdays2calendar(self.year, self.month):
         cal += f'{self.formatweek(week, events)}\n'
      return cal
   