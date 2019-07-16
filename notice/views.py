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
    return render(request,'notice/home.html',{'notice':notice,'posts':posts,'counts':counts})

def create(request):
    if request.method=='POST':
        form=NewNotice(request.POST)
        if form.is_valid:
            post=form.save(commit=False)
            post.pub_date=timezone.now()
            post.save()
            return redirect('home')
    else:
        form=NewNotice()
        return render(request,'notice/new.html',{'form':form})
    return
    
def update(request,pk):
    notice=get_object_or_404(Notice,pk = pk)
    form=NewNotice(request.POST, instance=notice)

    if form.is_valid():
        form.save()
        return redirect('home')

    return render(request,'notice/new.html',{'form':form})        

def delete(request,pk):
    notice=get_object_or_404(Notice,pk=pk)
    notice.delete()
    return redirect('home')

class SearchFormView(FormView):
    # form_class를 forms.py에서 정의했던 PostSearchForm으로 정의
    form_class = SearchForm
    template_name = 'notice/search.html'     #정보 보내고싶은 곳

    # 제출된 값이 유효성검사를 통과하면 form_valid 메소드 실행
    # 여기선 제출된 search_word가 PostSearchForm에서 정의한대로 Char인지 검사
    def form_valid(self, form):
        # 제출된 값은 POST로 전달됨
        # 사용자가 입력한 검색 단어를 변수에 저장
        search_word = self.request.POST['search_word']
        # Post의 객체중 제목이나 설명이나 내용에 해당 단어가 대소문자관계없이(icontains) 속해있는 객체를 필터링
        # Q객체는 |(or)과 &(and) 두개의 operator와 사용가능
        post_list = Notice.objects.filter(Q(title__icontains=search_word) | Q(body__icontains=search_word)) 

        context = {}
        # context에 form객체, 즉 PostSearchForm객체 저장
        context['form'] = form
        context['search_term'] = search_word
        context['object_list'] = post_list

        return render(self.request, 'notice/search.html', context)
