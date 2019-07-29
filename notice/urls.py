from django.urls import path
from . import views
from django.conf.urls import url

app_name='notice'

urlpatterns=[
    path('',views.read,name="read"),
    path('notice/<int:notice_id>/',views.detail,name="detail"),
    path('newnotice/',views.create,name="newnotice"),
    path('update/<int:pk>',views.update,name="update"),
    path('delete/<int:pk>',views.delete,name="delete"),
    url(r'^search',views.SearchFormView.as_view(),name='search'),   #search
]