from django.urls import path
from . import views
from django.conf.urls import url

urlpatterns=[
    path('',views.read,name="questionread"),
    path('question/<int:question_id>/',views.detail,name="questiondetail"),
    path('newquestion/',views.create,name="newquestion"),
    path('update/<int:question_id>',views.update,name="questionupdate"),    #수정 페이지를 보여주는 곳
    path('modify/',views.modify,name="questionmodify"),   #수정하는 곳
    path('delete/<int:pk>',views.delete,name="questiondelete"),
]
