from django.shortcuts import render,redirect,get_object_or_404
from django.utils import timezone
from django.core.paginator import Paginator
from django.views.generic.edit import FormView
from .models import Notice
from django.db.models import Q 
from django.views.generic.edit import FormView 
from .forms import NewNotice,SearchForm

# Create your views here.
def home(request):
    return render(request,'home.html')

def intro(request):
    return render(request,'notice/intro.html')


def detail(request, notice_id):
    notice_detail = get_object_or_404(Notice, pk=notice_id)
    return render(request, 'notice/detail.html', {'notice': notice_detail})

def read(request):
    notice=Notice.objects
    counts=Notice.objects.count()
    notice_list=Notice.objects.all()
    paginator=Paginator(notice_list,10)
    page=request.GET.get('page')
    posts=paginator.get_page(page)
    return render(request,'notice/board.html',{'posts':posts})

def create(request):
    if request.method=='POST':
        notice = get_object_or_404(Notice)
        notice.title =request.POST['title']
        notice.pub_date=timezone.now()
        notice.save()
        return redirect('noticeread')
    else:
        return render(request,'notice/new.html')
    return redirect('noticeread')

#update에서 먼저 수정하기페이지를 보여주고 notice.id를 넘겨줌
def update(request,notice_id):
    notice = get_object_or_404(Notice,pk = notice_id)
    return render(request, 'notice/update.html',{'notice':notice})    

#실질적인 수정은 여기서 동작,이때 pk값은 update에서 넘겨준 id(notice.id)값으로 가짐    
def modify(request):
    if request.method == 'POST':
        notice = get_object_or_404(Notice,pk = request.POST['id'])
        notice.title = request.POST['title']
        notice.body = request.POST['body']
        notice.save()
        #notice.update(pk = notice_id)
    return redirect('noticeread')  



def delete(request,pk):
    notice=get_object_or_404(Notice,pk=pk)
    notice.delete()
    return redirect('noticeread')
