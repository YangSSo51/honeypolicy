from django.db import models

# Create your models here.

class PolicyList(models.Model):
    # 제목
    title = models.CharField(max_length=100)
    # 내용
    body = models.TextField()

    # 작성자 
    writer = models.CharField(max_length=20, default="admin")

    # 등록일 , auto_now = True 가 매번 저장될때마다 시간이 저장
    pub_date = models.DateTimeField(auto_now=True)

    # 조회수 - 미구현 기본 = 0
    hits = models.IntegerField(default=0)
    
    # 첨부파일 - 미구현
    #upload_file = models.FileField()

    def hits_counter(self):
        self.hits += 1
        self.save()
        return self.hits

    def __str__(self):
        return self.title

