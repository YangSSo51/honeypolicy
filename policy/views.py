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
# 게시글 읽어와유~
def read(request):

    # policyCount = PolicyList.objects.count()

    policies = PolicyList.objects.all()

    # 검색을 할 경우를 나눈것!
    # posts 로 변수 통일 함 -> 템플릿에서 값 하나만 사용해서 나타내다 보니..ㅠ
    
    policyCount = PolicyList.objects.count()
    page = request.GET.get('page',1)
    paginator = Paginator(policies,6)
    try:
        policies = paginator.page(page)
    except PageNotAnInteger:
        policies = paginator.page(1)
    except EmptyPage:
        policies = paginator.page(paginator.num_pages)
    
    index = policies.number - 1
    max_index = len(paginator.page_range)
    start_index = index -2 if index >= 2 else 0
    if index < 2:
        end_index = 5 - start_index
    else:
        end_index = index + 3 if index <= max_index -3 else max_index
    
    page_range = list(paginator.page_range[start_index:end_index])

    context = { 'policies': policies , 'page_range':page_range, 'max_index':max_index-2 }


    # policies = policies.filter(title__contains=q, region__contains=r).order_by('-hits')   
    # policyCount = policies.filter(title__contains=q).count()

    # return render(request,'policyList.html' , {'policies':policies, 'policyCount':policyCount})
    return render(request,'policyList.html' , context)

def update(request,pk):
    # 어떤 게시글을 수정할지 가져오기
    policy = get_object_or_404(PolicyList, pk = pk)

    # 해당하는 글 객체 pk에 맞는 입력공간
    # 위에서 가져온 policyList 객체를 인자로 넣어주기
    # form = NewPolicyList(request.POST, instance=policy)
    # if form.is_valid():
    #     form.save()
    #     return redirect('policyread')
    
    # 다른 request 인경우??
    return render(request, 'updatePolicy.html', {'policy':policy})

#실질적인 수정은 여기서 동작,이때 pk값은 update에서 넘겨준 id(notice.id)값으로 가짐    
def modify(request):
    if request.method == 'POST':
        policy = get_object_or_404(PolicyList,pk = request.POST['id'])
        policy.title = request.POST['title']
        policy.body = request.POST['body']
        policy.region = request.POST['region']
        policy.age = request.POST['age']
        policy.start_date = request.POST['start_date']
        policy.end_date = request.POST['end_date']
        policy.educated = request.POST['educated']
        policy.save()
        #notice.update(pk = notice_id)
    return redirect('policyread')  

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
    policyDetail.hits_counter
    return render(request, 'detailPolicy.html', {'policyDetail':policyDetail, 'policy_id' : policy_id})


def search(request):
    policies = PolicyList.objects.all()

    # 상단에 검색하는 부분 
    # 제목이나 내용으로 검색하기
    searchTop = request.GET.get('searchTop','')
    
    # 정책 상세보기 페이지에서 검색
    searchPolicy = request.GET.get('searchPolicy','')

    if searchTop:
        # policies = policies.filter(title__contains=region)   
        # policies = PolicyList.objects.filter(Q(title__icontains=searchTop) | Q(body__icontains=searchTop)) 
        policies = PolicyList.objects.filter(body__icontains=searchTop) 
    elif searchPolicy:
        rangePolicy = request.GET.get('rangePolicy','')

        # 범위 x 검색만 -> 내용으로만 검색 하기
        if searchPolicy and not rangePolicy:
            policies = policies.filter(body__contains=searchPolicy)
            policyCount = policies.filter(body__contains=searchPolicy).count()
        # 범위 선택 , 검색 -> 범위에 맞는 검색 하기
        elif searchPolicy and rangePolicy:
            # 제목 검색
            if rangePolicy == 'title':
                policies = policies.filter(title__contains=searchPolicy)
                # policyCount = policies.filter(title__contains=searchPolicy).count()
            # 내용 검색
            elif rangePolicy == 'body':
                policies = policies.filter(body__contains=searchPolicy)
                # policyCount = policies.filter(body__contains=searchPolicy).count()
            # 지역 검색
            elif rangePolicy == 'region':
                policies = policies.filter(region__contains=searchPolicy)
                # policyCount = policies.filter(region__contains=searchPolicy).count()
    else:

        # 지역 - 서울 인천 경기 
        region = request.GET.get('region','')

        # 대상 - 청년 여성 중장년 무관
        target = request.GET.get('target','')

        # 학력 - 중졸 고졸 대졸 무관
        educated = request.GET.get('educated','')

        # start_date = request.GET.get('start_date','')
        # end_date = request.GET.get('end_date','')

        # 시작일 , 마감일 -> 리스트로 만들기
        # date_list = list(start_date,end_date)

        # 검색 리스트 
        # 지역 , 대상 , 학력 , 기간 
        # search_list = list(region, target, educated, date_list)

        # 리스트에서 값이 있는 것만 뽑기 
        # for n in search_list:
        #     result_list = []
        #     if n:
        #         result_list.append(n)
            
        
        # 지역
        if region and not target and not educated:
            policies = policies.filter(region__contains=region)   
        # 지역 + 대상
        # 대상을 내용에서 찾기
        elif region and target and not educated:
            policies = policies.filter(region__contains=region, body__contains=target)
        
        # 지역 + 학력 
        elif region and not target and educated:
            policies = policies.filter(region__contains=region, educated__contains=educated)
        # 지역 + 대상 + 학력
        elif region and target and educated:
            policies = policies.filter(region__contains=region, body__contains=target, educated__contains=educated)

        # 대상
        elif not region and target and not educated:
            policies = policies.filter(body__contains=target)
        # 대상 + 학력 
        elif not region and target and educated:
            policies = policies.filter(body__contains=target, educated__contains=educated)
        # 학력
        elif not region and not target and educated:
            policies = policies.filter(educated__contains=educated)
        # 아무것도 선택 안함    
        else:
            # 그냥 써놓은....
            pass

    page = request.GET.get('page',1)
    paginator = Paginator(policies,6)
    try:
        policies = paginator.page(page)
    except PageNotAnInteger:
        policies = paginator.page(1)
    except EmptyPage:
        policies = paginator.page(paginator.num_pages)
    
    index = policies.number - 1
    max_index = len(paginator.page_range)
    start_index = index -2 if index >= 2 else 0
    if index < 2:
        end_index = 5 - start_index
    else:
        end_index = index + 3 if index <= max_index -3 else max_index
    
    page_range = list(paginator.page_range[start_index:end_index])

    context = { 'policies': policies , 'page_range':page_range, 'max_index':max_index-2 }

    return render(request,'policyList.html' , context)
    # return render(request, 'policyList.html', {'policies':policies})

