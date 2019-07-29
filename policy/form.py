from django import forms

# 모델에서 정의한 PolicyList 
from .models import PolicyList

class NewPolicyList(forms.ModelForm):
    class Meta:
        model = PolicyList

        # 모든 항목 입력받으려묜...
        #fields = '__all__'
        
        fields = ['title','body','writer','region']