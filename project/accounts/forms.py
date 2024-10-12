from django import forms
from django.contrib.auth.forms import UserCreationForm
from allauth.account.forms import SignupForm
from .models import CustomUser

class CustomUserCreationForm(SignupForm):
    first_name = forms.CharField(max_length=8, label='姓',widget=forms.TextInput(attrs={'placeholder':'姓', 'class':'first_name'}))
    last_name = forms.CharField(max_length=8, label='名',widget=forms.TextInput(attrs={'placeholder':'名', 'class':'last_name'}))
    class Meta:
        model = CustomUser
        fields = ['email', 'username', 'first_name', 'last_name', 'password1', 'password2']

    def signup(self, request, user):
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.save()
        return user