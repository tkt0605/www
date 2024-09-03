from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from accounts.models import Account, CustomUser
from .models import  Group, Network
from django.views import generic
from .forms import CreateClassForm, CreateNetworkForm
from django.urls import reverse_lazy, reverse
def index(request):
    template = loader.get_template("index.html")
    accounts = Account.objects.order_by("-pk")[:100000]
    rooms = Group.objects.order_by("-pk")[:100000]
    context = {
        "csrf_token":"",
        "accounts": accounts,
        "rooms": rooms
    }
    return HttpResponse(template.render(context, request))
def page(request):
    template = loader.get_template("page.html")
    # urlのidのナンバーから、Accountモデルに一致するものを抽出。
    id = request.GET.get('id')
    account = Account.objects.get(pk=id)
    # Accountモデルの全DBを取得する。
    accounts = Account.objects.order_by('-pk')[:100000]
    context = {
        "csrf_token": "",
        "accounts": accounts,
        "account" : account,
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
def networks(request):
    accounts = Account.objects.order_by('-pk')[:10000000]
    networks = Network.objects.order_by('-pk')[:10000000]
    template = loader.get_template('network.html')
    context = {
        'csrf_token': '',
        'accounts': accounts,
        'networks': networks,
    }
    return HttpResponse(template.render(context, request))
def network(request):
    accounts = Account.objects.order_by('-pk')[:10000000]
    name = request.GET.get('name')
    network = Network.objects.get(name=name)
    template = loader.get_template('net.html')
    context = {
        'csrf_token': '',
        'accounts': accounts,
        'network': network,
    }
    return HttpResponse(template.render(context, request))
def root(request):
    return
class CreateClassView(generic.CreateView):
    form_class = CreateClassForm
    template_name = "create.html"
    # success_url = "/"
    def get_form_kwargs(self, *args, **kwargs):
        kwargs = super().get_form_kwargs(*args, **kwargs)
        kwargs['mainuser'] = self.request.user
        form = self.request.user.username
        kwargs['managername'] = Account.objects.get(name=form)
        return kwargs
    ## classフォームから、get_context_data()を取得する。
    def get_context_data(self, **kwargs):
        #親クラスの get_context_data メソッドを呼び出す:
        context = super().get_context_data(**kwargs)
        #既存のコンテキストデータを取得:
        accounts = Account.objects.order_by('-pk')[:100000]
        #追加のコンテキストデータをマージ,htmlにコンテキストを表示できるようにする。
        context['accounts'] = accounts
        return context
    def get_absolute_url(self):
        return reverse('community', kwargs={"name": self.kwargs["name"]})
form_create = CreateClassView.as_view()

class CreateNetworkView(generic.CreateView):
    form_class = CreateNetworkForm
    template_name = "create-net.html"
    def get_form_kwargs(self, *args, **kwargs):
        kwargs = super().get_form_kwargs(*args, **kwargs)
        kwargs['mainuser'] = self.request.user
        return kwargs
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        accounts = Account.objects.order_by('-pk')[:10000000]
        context['accounts'] = accounts
        return context
    def get_success_url(self):
        return reverse('networks')
form_net = CreateNetworkView.as_view()