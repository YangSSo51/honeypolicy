from django.shortcuts import render, redirect
from django.contrib import auth
from django.contrib.auth.models import User
from .models import People

    
def signup(request):
    if request.method == 'POST':
        if request.POST['password1'] == request.POST['password2']:
            user = People.objects.create_user(username=request.POST['username'], password=request.POST['password1'],
            gender = request.POST['gender'],phone = request.POST['phone'],birth=request.POST['birth'])

            auth.login(request,user)
            return redirect('home')

    return render(request,"signup.html")

def login(request):
    if request.user.is_authenticated:
        return redirect('home')
    else:
        if request.method == 'POST':
            username = request.POST['username']
            password = request.POST['password']
            user = auth.authenticate(request, username=username, password=password)
            if user is not None:
                auth.login(request, user)
                return redirect('home')
            else:
                return render(request, 'login.html', {'error': 'username or password is incorrect.'})

        return render(request,"login.html")

def logout(request):
    if request.method == 'GET':
        auth.logout(request)
        return redirect('home')
    return render(request,'login.html')

def mypage(request):
    return render(request, 'mypage.html')

def modify(request):
    pass