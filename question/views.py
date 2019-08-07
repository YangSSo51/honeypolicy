from django.shortcuts import render,redirect,get_object_or_404
from django.utils import timezone
from django.core.paginator import Paginator
from django.views.generic.edit import FormView
from .models import Question,Comment
from django.db.models import Q 
from django.views.generic.edit import FormView 
from .forms import NewQuestion,CommentForm
from django.contrib.auth.decorators import login_required

# Create your views here.

def detail(request, question_id):
    question_detail = get_object_or_404(Question, pk=question_id)
    return render(request, 'question/detail.html', {'question': question_detail})

def comment_create(request, question_id):
    # 요청 메서드가 POST방식 일 때만 처리
    if request.method == 'POST':
        # Post인스턴스를 가져오거나 404 Response를 돌려줌
        question = get_object_or_404(Question, pk=question_id)
        # request.POST에서 'content'키의 값을 가져옴
        content = request.POST.get('content')
        writer = request.POST.get('writer')

        # 내용이 전달 된 경우, Comment객체를 생성 및 DB에 저장
        Comment.objects.create(
            question=question,
            # 작성자는 현재 요청의 사용자로 지정
            comment_contents=content,
            comment_writer=writer,
        )
        return redirect('detail_comment') 
  
def comment_remove(request, pk):
    comment = get_object_or_404(Comment, pk=pk)
    comment.delete()
    return redirect('detail_comment') 


def read(request):
    question=Question.objects
    counts=Question.objects.count()
    question_list=Question.objects.all()
    paginator=Paginator(question_list,10)
    page=request.GET.get('page')
    posts=paginator.get_page(page)
    #page 추가
    max_index = len(paginator.page_range)
    page_numbers_range = 5
    current_page = int(page) if page else 1
    start_index = int((current_page - 1) / page_numbers_range) * page_numbers_range
    end_index = start_index + page_numbers_range
    if end_index >= max_index:
        end_index = max_index

    page_range = paginator.page_range[start_index:end_index]
    return render(request,'question/home.html',{'question':question,'posts':posts,'counts':counts,'page_range':page_range})

def create(request):
    if request.user.is_staff:
        if request.method=='POST':
            question = Question(title = request.POST["title"],body = request.POST["body"],
                                pub_date=timezone.now(),writer = request.POST["writer"])
            question.save()
            return redirect('home')
        else:
            return render(request,'newQuestion.html')
    else:
        return render(request,'home.html',{"error":"스태프가 아닙니다"})



def update(request,pk):
    question=get_object_or_404(Question,pk = pk)
    form=NewQuestion(request.POST, instance=question)

    if form.is_valid():
        form.save()
        return redirect('home')

    return render(request,'question/new.html',{'form':form})        

def delete(request,pk):
    question=get_object_or_404(Question,pk=pk)
    question.delete()
    return redirect('home')