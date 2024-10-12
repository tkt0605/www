from django.shortcuts import render

# Create your views here.
from django.contrib.auth import login, logout
from django.contrib.auth.views import LoginView, LogoutView
from django.shortcuts import render, redirect
from django.urls import reverse_lazy
from django.views import View
from .forms import SignUpForm
class SignUpView(View):
    def get(self, request):
        form = SignUpForm()
        return render(request, 'account/signup.html', {'form': form})

    def post(self, request):
        form = SignUpForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('login')
        return render(request, 'account/signup.html', {'form': form})
# def create_user(request):
#     if request.method == 'POST':
#         form = SignUpForm(request.POST)
#         if form.is_valid():
#             user = form.save(commit=False)
#             user.set_password(form.cleaned_data['password'])  # パスワードをハッシュ化
#             user.save()
#             return redirect('index')  # 作成後のリダイレクト
#     else:
#         form = SignUpForm()
    
#     return render(request, 'account/signup.html', {'form': form})