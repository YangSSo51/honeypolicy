from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone

# paginator 사용하려고
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

# views.py 에서 사용하려고
from .models import PolicyList
from .form import NewPolicyList

# 처음 보여지는 화면
def policyList(request):
    return render(request, 'home.html')

# 글쓰기~~
def create(request):
    # 새로운 데이터 저장하는 하기 == POST
    if request.method == 'POST':
        form = NewPolicyList(request.POST)
        if form.is_valid:
            post = form.save(commit=False)
            #post.pub_date = timezone.now()
            post.save()
            return redirect('policyList')
    # 글쓰기 페이지 띄우기 == GET
    else:
        # 입력받을 수 있는 걸 띄우기
        form = NewPolicyList()
        return render(request, 'newPolicyList.html', {'form':form})
    
# 게시글 읽어와유~
def read(request):

    policyCount = PolicyList.objects.count()

    policies = PolicyList.objects.all()

    page = request.GET.get('page',1)
    paginator = Paginator(policies,10)

    try:
        posts = paginator.page(page)
    except PageNotAnInteger:
        posts = paginator.page(1)
    except EmptyPage:
        posts = paginator.page(paginator.num_pages)

    return render(request,'policyList.html' , {'policies':policies, 'posts':posts, 'policyCount':policyCount})

def update(request,pk):
    # 어떤 게시글을 수정할지 가져오기
    policy = get_object_or_404(PolicyList, pk = pk)

    # 해당하는 글 객체 pk에 맞는 입력공간
    # 위에서 가져온 policyList 객체를 인자로 넣어주기
    form = NewPolicyList(request.POST, instance=policy)
    if form.is_valid():
        form.save()
        return redirect('policyList')
    
    # 다른 request 인경우??
    return render(request, 'newPolicyList.html', {'form':form})

def delete(request,pk):
    policy = get_object_or_404(PolicyList, pk = pk)
    policy.delete()
    return redirect('policyList')

def detail(request, policy_id):
    policyDetail = get_object_or_404(PolicyList, pk=policy_id)
    return render(request, 'detailPolicy.html', {'policyDetail':policyDetail, 'policy_id' : policy_id})
