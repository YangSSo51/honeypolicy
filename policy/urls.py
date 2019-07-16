from django.urls import path

from policy import views


urlpatterns = [
    path('', views.read, name="policyList"),
    path('newPost', views.create, name="newPost"),
    path('update/<int:pk>', views.update, name="update"),
    path('delete/<int:pk>', views.delete, name="delete"),
    path('detail/<int:policy_id>', views.detail, name="detail"),
    
]
