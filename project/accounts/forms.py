from django import forms
from django.contrib.auth.forms import UserCreationForm
from allauth.account.forms import SignupForm
from .models import CustomUser

class CustomUserCreationForm(SignupForm):
    last_name = forms.CharField(max_length=30, label='名字')
    first_name = forms.CharField(max_length=30, label='名前')
    class Meta:
        model = CustomUser
        fields = ['email', 'username', 'first_name', 'last_name', 'password1', 'password2']
        widgets = {
            'first_name': forms.TextInput(
                attrs={
                    "class": "first_name",
                    "placeholder": "姓",
                    "max-length": 8,
                }
            ),
            'last_name': forms.TextInput(
                attrs={
                    'class': 'last_name',
                    "placeholder": "名",
                    "max-length": 8
                }
            ),
        }
    def signup(self, request, user):
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.save()
        return user