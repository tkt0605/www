from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from accounts.models import Account, CustomUser
from .models import  Group
from django.views import generic
from .forms import CreateClassForm
from django.urls import reverse_lazy, reverse
def index(request):
    template = loader.get_template("index.html")
    accounts = Account.objects.order_by("-pk")[:100000]
    # rooms = Group.objects.order_by("-name")[:100000]
    context = {
        "csrf_token":"",
        "accounts": accounts,
        # "rooms": rooms
    }
    return HttpResponse(template.render(context, request))
def page(request):
    template = loader.get_template("page.html")
    id = request.GET.get('id')
    account = Account.objects.get(pk=id)
    accounts = Account.objects.order_by('-pk')[:100000]
    context = {
        "csrf_token": "",
        "accounts": accounts,
        "account" : account,
    }
    return HttpResponse(template.render(context, request))
def pages(request):
    template = loader.get_template("header.html", "index.html")
    accounts = Account.objects.order_by("-pk")[:100000]
    context ={
        "csrf_token": "",
        "accounts": accounts,
    }
    return HttpResponse(template.render(context, request))
def page1(request):
    account =Account.objects.order_by("-pk")[:100000]
    template = loader.get_template("header.html", "page.html")
    context = {
        "csrf_token": "",
        "account": account,
    }
    return HttpResponse(template.render(context, request))
def community(request, name):
    accounts =Account.objects.order_by("-pk")[:100000]
    community = Group.objects.get(name=name)
    template = loader.get_template('class.html')
    context = {
        "csrf_token": "",
        "community":community,
        "accounts": accounts,
    }
    return HttpResponse(template.render(context, request))
class CreateClassView(generic.CreateView):
    form_class = CreateClassForm
    template_name = "create.html"
    success_url = "/"
    def get_form_kwargs(self, *args, **kwargs):
        kwargs = super().get_form_kwargs(*args, **kwargs)
        kwargs['mainuser'] = self.request.user
        form = self.request.user.username
        kwargs['managername'] = Account.objects.get(name=form)
        return kwargs
    def get_queryset(self):
        return Group.objects.all()
    def get_absolute_url(self):
        return reverse('community', kwargs={"name": self.kwargs["name"]})
form_create = CreateClassView.as_view()
        
