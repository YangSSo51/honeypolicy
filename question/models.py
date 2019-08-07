from django.db import models

# Create your models here.
# Create your models here.
from django.db import models

# Create your models here.
#번호,제목,작성자,등록일,조회수,글,첨부파일
class Question(models.Model):
    title=models.CharField(max_length=100)  #제목
    writer=models.CharField(max_length=25)  #작성자
    pub_date=models.DateField(auto_now=True) #등록일
    hit=models.PositiveIntegerField(default=0)    #조회수
    body=models.CharField(max_length=500)   #글
    def __str__(self):
        return self.title
    
    @property   #조회수 세주는 거
    def update_counter(self):
        self.hit=self.hit+1
        self.save()

class Comment(models.Model):
    question=models.ForeignKey(Question,on_delete=models.CASCADE,null=True,related_name='comments')
    comment_date=models.DateTimeField(auto_now_add=True)
    comment_contents=models.CharField(max_length=200)
    comment_writer=models.CharField(max_length=200,default="admin")

    class Meta:
        ordering=['-id']