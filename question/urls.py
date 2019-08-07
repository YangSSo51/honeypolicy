from django.urls import path
from . import views
from django.conf.urls import url

urlpatterns=[
    path('',views.read,name="questionread"),
    path('question/<int:question_id>/',views.detail,name="questiondetail"),
    path('newquestion/',views.create,name="newquestion"),
    path('update/<int:pk>',views.update,name="questionupdate"),
    path('delete/<int:pk>',views.delete,name="questiondelete"),
]
