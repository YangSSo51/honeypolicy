from django import forms
from .models import Question,Comment

#제목,글,첨부파일
class NewQuestion(forms.ModelForm):
    class Meta:
        model=Question
        fields=['title','writer','body']

class CommentForm(forms.ModelForm):
    class Meta:
        model=Comment
        fields=['comment_writer','comment_contents']




