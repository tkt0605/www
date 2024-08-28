from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from accounts.models import Account, CustomUser
# from .models import  Group
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