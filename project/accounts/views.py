from django.shortcuts import render

# Create your views here.
from django.contrib.auth import login, logout
from django.contrib.auth.views import LoginView, LogoutView
from django.shortcuts import render, redirect
from django.urls import reverse_lazy
from django.views import View
# from .forms import SignUpForm
from .forms import CustomUserCreationForm

# class SignUpView(View):
#     def get(self, request):
#         form = SignUpForm()
#         return render(request, 'accounts/signup.html', {'form': form})

#     def post(self, request):
#         form = SignUpForm(request.POST)
#         if form.is_valid():
#             user = form.save()
#             login(request, user)
#             return redirect('home')
#         return render(request, 'accounts/signup.html', {'form': form})
from django.shortcuts import render, redirect
from .forms import CustomUserCreationForm

def signup(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')  # ログインページにリダイレクト
    else:
        form = CustomUserCreationForm()
    return render(request, 'accounts/signup.html', {'form': form})
