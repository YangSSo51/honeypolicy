from django.db import models

# Create your models here.

class PolicyList(models.Model):

    # 글 번호 - 필요할거같아유 
    # id = models.AutoField(primary_key=True)

    # 제목
    title = models.CharField(max_length=100)
    # 설명
    body = models.TextField()

    # 작성자 
    writer = models.CharField(max_length=20, default="admin")

    # 등록일 , auto_now = True 가 매번 저장될때마다 시간이 저장
    pub_date = models.DateTimeField(auto_now=True)

    # 조회수 - 미구현 기본 = 0
    hits = models.IntegerField(default=0)
    
    # 첨부파일 - 미구현
    #upload_file = models.FileField()

    REGION_CATEGORY = (
        ('서울','서울'),
        ('인천','인천'),
        ('경기','경기')
    )
    # 지역
    region = models.CharField(max_length=20, choices=REGION_CATEGORY)

    # 연령
    age = models.IntegerField(default=20)

    # 정책 시작 기간
    start_date = models.DateField(null=True)

    # 정책 끝 기간
    end_date = models.DateField(null=True)

    educate_category = (
        ("중졸 이상", "중졸 이상"),
        ("고졸 이상", "고졸 이상"),
        ("대졸 이상", "대졸 이상"),
        ("무관", "무관"),
        ("정보 없음","정보 없음")
    )
    # 학력
    educated = models.CharField(null=True, max_length=120, choices=educate_category)

    # 신청 방법
    regist_way = models.TextField(null=True)

    # 홈페이지 url
    url = models.TextField(default="https://www.youthcenter.go.kr")

    # 조회수 기준으로 내림차순 정렬 하기 
    class Meta:
        ordering = ['-hits']

    def hits_counter(self):
        self.hits += 1
        self.save()
        return self.hits

    def __str__(self):
        return self.title
