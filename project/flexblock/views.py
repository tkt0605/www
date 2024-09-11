from django.shortcuts import render
from django.http import HttpResponse, HttpResponseBadRequest
from django.template import loader
from accounts.models import Account, CustomUser
from .models import  Group, Network, RootAuth, Post, GroupMembership, AddNetwork
from django.views import generic
from .forms import CreateClassForm, CreateNetworkForm, CreatePostForm
from django.urls import reverse_lazy, reverse
from django.shortcuts import get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
def error(request):
    template = loader.get_template('error.html')
    accounts = Account.objects.order_by('-pk')[:100000]
    context = {
        "csrf_token": "",
        "accounts": accounts
    }
    return HttpResponse(template.render(context, request))
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
@login_required
def page(request, pk):
    template = loader.get_template("page.html")
    # urlのidのナンバーから、Accountモデルに一致するものを抽出。

    account = Account.objects.get(pk=pk)
    # Accountモデルの全DBを取得する。
    accounts = Account.objects.order_by('-pk')[:100000]
    profile_user = get_object_or_404(CustomUser, pk=pk)
    mutual_auth = RootAuth.objects.filter(
        user=request.user, 
        target_user=profile_user, 
        is_approved_by_user=True, 
        is_approved_by_target=True
    ).exists() or RootAuth.objects.filter(
        user=profile_user, 
        target_user=request.user, 
        is_approved_by_user=True, 
        is_approved_by_target=True
    ).exists()
    auth_request_sent = RootAuth.objects.filter(user=request.user, target_user=profile_user).exists()
    auth_requests_received = RootAuth.objects.filter(target_user=request.user, is_approved_by_target=False)
    context = {
        "csrf_token": "",
        "accounts": accounts,
        "account" : account,
        "profile_user": profile_user,
        "auth_request_sent": auth_request_sent,
        "auth_requests_received": auth_requests_received,
        "mutual_auth": mutual_auth,
    }
    return HttpResponse(template.render(context, request))
@login_required
def community(request, name):
    # データの取得
    accounts = Account.objects.order_by("-pk")[:100000]
    group = get_object_or_404(Group, name=name)
    template = loader.get_template('class.html')
    posts = Post.objects.order_by('-pk')[:1000000]
    user_account = request.user.account
    user = request.user
    network_exists = Network.objects.filter(mainuser=user).exists()
    is_member = GroupMembership.objects.filter(account=user_account, group=group).exists()
    # is_network = AddNetwork.objects.filter(name = network_exists, group=group).exists()
    is_network = AddNetwork.objects.filter(group=group, name__mainuser=user).exists()
    groupmemberships = GroupMembership.objects.order_by('-pk')[:10000]
    # networks = Network.objects.order_by('-pk')[:1000000]
    networks = Network.objects.filter(mainuser=user).order_by('-pk')[:1000000]
    context = {
        "csrf_token": "",
        "posts": posts,
        "community": group,
        "accounts": accounts,
        "is_member":is_member,
        "groupmemberships": groupmemberships,
        "is_network": is_network,
        "networks": networks,
        "network_exists": network_exists
    }
    # ユーザーがグループに参加できるかを確認
    if group.mainuser == request.user:
        return HttpResponse(template.render(context, request))
    if group.visibility== "local":
        user = request.user
        can_join = group.can_user_join(user)
        if not can_join :
                return redirect('error') 
        else:
            return HttpResponse(template.render(context, request))
    return HttpResponse(template.render(context, request))
@login_required
def join(request, name):
    group = get_object_or_404(Group, name=name)
    user_account = request.user.account
    join_exist = GroupMembership.objects.filter(account=user_account, group=group).exists()
    if not join_exist:
        GroupMembership.objects.create(account=user_account, group=group)
    return redirect('community', name=name)
@login_required
def joinout(request, name):
    group = get_object_or_404(Group, name=name)
    user_account = request.user.account
    join_exist = GroupMembership.objects.filter(account=user_account, group=group).exists()
    if join_exist:
        exists_memeber = GroupMembership.objects.get(account=user_account, group=group)
        exists_memeber.delete()
    return redirect('community', name=name)
@login_required
def add_network(request, name, pk):
    group = get_object_or_404(Group, name=name)
    network_name =get_object_or_404(Network,pk=pk)
    add_network = AddNetwork.objects.filter(name=network_name, group=group).exists()
    if not add_network:
        AddNetwork.objects.create(name=network_name, group=group)
    return redirect('community', name=name)
def networks(request):
    accounts = Account.objects.order_by('-pk')[:10000000]
    networks = Network.objects.order_by('-pk')[:10000000]
    template = loader.get_template('network.html')
    message = "全ネットワーク"
    context = {
        'csrf_token': '',
        'accounts': accounts,
        'networks': networks,
        "message": message,
    }
    return HttpResponse(template.render(context, request))
def network(request, name):
    accounts = Account.objects.order_by('-pk')[:10000000]
    network = Network.objects.get(name=name)
    members = AddNetwork.objects.order_by('-pk')[:10000000]
    template = loader.get_template('net.html')
    context = {
        'csrf_token': '',
        'accounts': accounts,
        'network': network,
        "members": members,
    }
    if network.mainuser == request.user:
        return HttpResponse(template.render(context, request))
    if network.visibility == 'local':
        user = request.user
        can_join = network.can_user_join(user)
        if not can_join :
                return redirect('error') 
        else:
            return HttpResponse(template.render(context, request))
    return HttpResponse(template.render(context, request))
# Publicネットワークのみ
def public(request):
    networks = Network.objects.filter(visibility='public')
    accounts = Account.objects.order_by('-pk')[:1000000000]
    template = loader.get_template('network.html')
    message = "Publicネットワーク"
    context = {
        'networks': networks,
        'accounts': accounts,
        'mesaage':message,
    }
    return HttpResponse(template.render(context, request))

# Localネットワークのみ
def local(request):
    networks = Network.objects.filter(visibility='local')
    accounts = Account.objects.order_by('-pk')[:1000000000]
    template = loader.get_template('network.html')
    message = "Localネットワーク"
    context = {
        'networks': networks,
        'accounts': accounts,
        "message": message,
    }
    return HttpResponse(template.render(context, request))
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
    # def get_absolute_url(self):
    #     return reverse('community', kwargs={"name": self.kwargs["name"]})
    def get_absolute_url(self):
        return reverse('community', name=self.kwargs["name"])
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
class CreatePostView(generic.CreateView):
    form_class = CreatePostForm
    template_name = "create-post.html"
    def get_form_kwargs(self, *args, **kwargs):
        kwargs = super().get_form_kwargs(*args, **kwargs)
        form = CreatePostForm(self.request.FILES, self.request.POST, instance=Account and Group)
        form.instance.name = self.kwargs['name']
        kwargs['mainuser'] = self.request.user
        kwargs['destination'] = Group.objects.get(name=form.instance.name)
        kwargs['username'] = Account.objects.get(name=self.request.user.username)
        return kwargs
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        accounts = Account.objects.order_by('-pk')[:10000000]
        context['accounts'] = accounts
        return context
    def get_absolute_url(self):
        return reverse('community', name=self.kwargs["name"])
form_post = CreatePostView.as_view()
@login_required
def send_auth_request(request, pk):
    """ユーザーに認証リクエストを送信するビュー"""

    # URLのパスパラメータ`pk`を使用してユーザーを取得
    profile_user = get_object_or_404(CustomUser, pk=pk)

    # 認証リクエストを送信するロジック
    if not RootAuth.objects.filter(user=request.user, target_user=profile_user).exists():
        RootAuth.objects.create(user=request.user, target_user=profile_user)

    return redirect('page', pk=pk)
@login_required
def approve_auth_request(request, pk):
    """認証リクエストを承認するビュー"""
    auth_request = get_object_or_404(RootAuth, pk=pk)

    # ユーザーがリクエストの送信者または受信者であるかを確認
    if request.user == auth_request.target_user and not auth_request.is_approved_by_target:
        auth_request.is_approved_by_target = True
        auth_request.save()
        # 相手からのリクエストも承認するロジックを追加
        reverse_request = RootAuth.objects.filter(user=auth_request.target_user, target_user=auth_request.user).first()
        if reverse_request:
            reverse_request.is_approved_by_user = True
            reverse_request.save()

    elif request.user == auth_request.user and not auth_request.is_approved_by_user:
        auth_request.is_approved_by_user = True
        auth_request.save()

        # 相手からのリクエストも承認するロジックを追加
        reverse_request = RootAuth.objects.filter(user=auth_request.target_user, target_user=auth_request.user).first()
        if reverse_request:
            reverse_request.is_approved_by_target = True
            reverse_request.save()

    return redirect('page', pk=request.user.id)
@login_required
def not_approve_auth_request(request, pk):
    not_approve_auth_request = get_object_or_404(RootAuth, pk=pk)
    if request.user == not_approve_auth_request.target_user and not not_approve_auth_request.is_approved_by_target:
        not_approve_auth_request.is_approved_by_target = True
        not_approve_auth_request.save()
        reverse_request = RootAuth.objects.filter(user=not_approve_auth_request.target_user, target_user=not_approve_auth_request.user).first()
        if reverse_request:
            reverse_request.is_approved_by_user = False
            reverse_request.save()
    elif request.user == not_approve_auth_request.user and not not_approve_auth_request.is_approved_by_user:
        not_approve_auth_request.is_approved_by_user = True
        not_approve_auth_request.save()
        
        reverse_request = RootAuth.objects.filter(user=not_approve_auth_request.target_user, target_user=not_approve_auth_request.user).first()
        if reverse_request:
            reverse_request.is_approved_by_target = False
            reverse_request.save()
    return redirect('page', pk=request.user.id)