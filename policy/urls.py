from django.urls import path

from policy import views


urlpatterns = [
    path('', views.read, name="policyread"),
    path('newPost', views.create, name="newPost"),
    path('update/<int:pk>', views.update, name="policyupdate"),
    path('delete/<int:pk>', views.delete, name="policydelete"),
    path('detail/<int:policy_id>', views.detail, name="policydetail"),
    path('search/', views.search , name="policysearch"),
    path('regist/<int:pk>', views.regist, name="policyregist"),
]