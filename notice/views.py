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
        form=NewNotice(request.POST)
        if form.is_valid:
            post=form.save(commit=False)
            post.pub_date=timezone.now()
            post.save()
            return redirect('noticeread')
    else:
        form=NewNotice()
        return render(request,'notice/new.html',{'form':form})
    return redirect('noticeread')

def update(request,notice_id):
    notice = get_object_or_404(Notice,pk = notice_id)
    if request.method == 'POST':
        notice.title = request.POST['title']
        notice.body = request.POST['body']
        #notice.update(pk = notice_id)
    return render(request, 'notice/update.html')    
  

def delete(request,pk):
    notice=get_object_or_404(Notice,pk=pk)
    notice.delete()
    return redirect('noticeread')
