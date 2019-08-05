from django.urls import path
from . import views
from django.conf.urls import url

urlpatterns=[
    path('',views.read,name="noticeread"),
    path('base/',views.base,name="base"),
    path('notice/<int:notice_id>/',views.detail,name="noticedetail"),
    path('newnotice/',views.create,name="newnotice"),
    path('update/<int:pk>',views.update,name="noticeupdate"),
    path('delete/<int:pk>',views.delete,name="noticedelete"),
    url(r'^search',views.SearchFormView.as_view(),name="noticesearch"),   #search
]