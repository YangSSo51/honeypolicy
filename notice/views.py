from django.shortcuts import render,redirect,get_object_or_404
from django.utils import timezone
from django.core.paginator import Paginator
from django.views.generic.edit import FormView
from .models import Notice
from policy.models import PolicyList
from django.db.models import Q 
from django.views.generic.edit import FormView 
from .forms import NewNotice,SearchForm

# Create your views here.
def home(request):
    # 미누기의 이해를 위한..주석
    # 정책들 객체 받아오기 
    # 조회수 비교해서 제일 높은 순으로 3개? 만 뽑아서 리스트 만들기
    # 만약 조회수가 0이면 리스트에 제외 (안함)

    policies = PolicyList.objects.all()

    hot_policies = []
    for policy in policies:
        hot_policies.append(policy)
    
    sorted(hot_policies, key=lambda hot_policy: hot_policy.hits)
    # hot_policies.sort(key= lambda hot_policies : hot_policies.hits)
    
    result_hot_policies = []
    count = 0
    for hot_policy in hot_policies:
        if count == 3:
            count = 0
            break
        result_hot_policies.append(hot_policy)
        count += 1


    return render(request,'home.html', {'result_hot_policies':result_hot_policies})

def intro(request):
    return render(request,'notice/intro.html')


def detail(request, notice_id):
    notice_detail = get_object_or_404(Notice, pk=notice_id)
    notice_detail.update_counter

    return render(request, 'notice/detail.html', {'notice': notice_detail})

def read(request):
    notice=Notice.objects
    counts=Notice.objects.count()
    notice_list=Notice.objects.all()
    paginator=Paginator(notice_list,10)
    page=request.GET.get('page')
    posts=paginator.get_page(page)
    return render(request,'notice/board.html',{'posts':posts, 'counts':counts})



def create(request):
    # 새로운 데이터 저장하는 하기 == POST
    if request.method == 'POST':
        notice = Notice(
            title = request.POST["title"], body = request.POST["body"])
        notice.save()
        return redirect('noticeread')
    # 글쓰기 페이지 띄우기 == GET
    else:
        return render(request, 'notice/new.html')

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
