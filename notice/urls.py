from django.urls import path
from . import views
from django.conf.urls import url


urlpatterns=[
    path('',views.read,name="noticeread"),
    path('intro/', views.intro, name='intro'),
    path('notice/<int:notice_id>/',views.detail,name="noticedetail"),
    path('newnotice/',views.create,name="newnotice"),
    path('update/<int:notice_id>',views.update,name="noticeupdate"),    #수정 페이지를 보여주는 곳
    path('modify/',views.modify,name="noticemodify"),   #수정하는 곳
    path('delete/<int:pk>',views.delete,name="noticedelete"),
]