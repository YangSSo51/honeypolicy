from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone

# paginator 사용하려고
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

# views.py 에서 사용하려고
from .models import PolicyList
from .form import NewPolicyList

from django.db.models import Q
from django.apps import apps



# 처음 보여지는 화면
def policyList(request):
    return render(request, 'home.html')

# 글쓰기~~
def create(request):
    # 새로운 데이터 저장하는 하기 == POST
    if request.method == 'POST':
        policy = PolicyList(
            title = request.POST["title"], body = request.POST["body"],
            region = request.POST["region"], age= request.POST["age"],
            start_date = request.POST["start_date"], end_date=request.POST["end_date"],
            educated = request.POST["educated"],url = request.POST["url"])
        policy.save()
        return redirect("policyread")
    # 글쓰기 페이지 띄우기 == GET
    else:
        # 입력받을 수 있는 걸 띄우기
        birth = range(1900,2019)
        return render(request, 'newPolicyList.html',{"birth":birth})
    
# 게시글 읽어와유~
''' def read(request):

    # policyCount = PolicyList.objects.count()

    policies = PolicyList.objects.all()

    # 검색을 할 경우를 나눈것!
    # posts 로 변수 통일 함 -> 템플릿에서 값 하나만 사용해서 나타내다 보니..ㅠ
    q = request.GET.get('q','')
    if q:
        # 조회수로 내림차순 정렬하면서 검색  
        r = request.GET.get('region','')
        if r:
            posts = policies.filter(title__contains=q, region__contains=r).order_by('-hits')
        else:
            posts = policies.filter(title__contains=q).order_by('-hits')
        policyCount = policies.filter(title__contains=q).count()
    else:
        policyCount = PolicyList.objects.count()
        page = request.GET.get('page',1)
        paginator = Paginator(policies,10)
        try:
            posts = paginator.page(page)
        except PageNotAnInteger:
            posts = paginator.page(1)
        except EmptyPage:
            posts = paginator.page(paginator.num_pages)

    
    return render(request,'policyList.html' , {'policies':policies, 'posts':posts, 'policyCount':policyCount}) '''
def read(request):

    # policyCount = PolicyList.objects.count()

    policies = PolicyList.objects.all()

    # 검색을 할 경우를 나눈것!
    # posts 로 변수 통일 함 -> 템플릿에서 값 하나만 사용해서 나타내다 보니..ㅠ
    q = request.GET.get('q','')

    r = request.GET.get('region','')

    if q and not r:
        policies = policies.filter(title__contains=q)
        policyCount = policies.filter(title__contains=q).count()
    elif not q and r:
        policies = policies.filter(region__contains=r)
        policyCount = policies.filter(region__contains=r).count()
    else:
        policies = policies.filter(title__contains=q, region__contains=r)
        policyCount = policies.filter(title__contains=q, region__contains=r).count()

    # policies = policies.filter(title__contains=q, region__contains=r).order_by('-hits')   
    # policyCount = policies.filter(title__contains=q).count()

    return render(request,'policyList.html' , {'policies':policies, 'policyCount':policyCount})

def update(request,pk):
    # 어떤 게시글을 수정할지 가져오기
    policy = get_object_or_404(PolicyList, pk = pk)

    # 해당하는 글 객체 pk에 맞는 입력공간
    # 위에서 가져온 policyList 객체를 인자로 넣어주기
    form = NewPolicyList(request.POST, instance=policy)
    if form.is_valid():
        form.save()
        return redirect('policyread')
    
    # 다른 request 인경우??
    return render(request, 'newPolicyList.html', {'form':form})

def regist(request,pk):
    Cal = apps.get_model('cal', 'Event')
    User = apps.get_model('people',"People")
    user = get_object_or_404(User, pk=request.user.id)
    policy = get_object_or_404(PolicyList, pk=pk)

    calender = Cal(
        user = user.username,
        title = policy.title, description = policy.body,
        start_date = policy.start_date, end_date = policy.end_date,
        user_id = user,policy_id=policy)
    calender.save()

    return redirect('policyread')

def delete(request,pk):
    policy = get_object_or_404(PolicyList, pk = pk)
    policy.delete()
    return redirect('policyread')

def detail(request, policy_id):
    policyDetail = get_object_or_404(PolicyList, pk=policy_id)
    return render(request, 'detailPolicy.html', {'policyDetail':policyDetail, 'policy_id' : policy_id})

def search(request):
    policies = PolicyList.objects.all()

    # 상단에 검색하는 부분 
    searchTop = request.GET.get('searchTop','')
    
    # 지역 - 서울 인천 경기 
    region = request.GET.get('region','')

    # 대상 - 청년 여성 중장년 무관
    target = request.GET.get('target','')

    # 학력 - 중졸 고졸 대졸 무관
    educated = request.GET.get('educated','')


    if search:
        # policies = policies.filter(title__contains=region)   
        policies = PolicyList.objects.filter(Q(title__icontains=searchTop) | Q(body__icontains=searchTop)) 
    else:
        # 지역
        if region and not target and not educated:
            policies = policies.filter(region__contains=region)   
        # 지역 + 대상
        elif region and target and not educated:
            policies = policies.filter(region__contains=region, target__contains=target)
        # 지역 + 학력 
        elif region and not target and educated:
            policies = policies.filter(region__contains=region, educated__contains=educated)
        # 지역 + 대상 + 학력
        elif region and target and educated:
            policies = policies.filter(region__contains=region, target__contains=target, educated__contains=educated)
        # 대상
        elif not region and target and not educated:
            policies = policies.filter(target__contains=target)
        # 대상 + 학력 
        elif not region and target and educated:
            policies = policies.filter(target__contains=target, educated__contains=educated)
        # 학력
        elif not region and not target and educated:
            policies = policies.filter(educated__contains=educated)
        # 아무것도 선택 안함    
        else:
            # 그냥 써놓은....
            pass

    return render(request, 'policyList.html', {'policies':policies})