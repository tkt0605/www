from django.shortcuts import render
from django.http import HttpResponse, HttpResponseBadRequest
from django.template import loader
from accounts.models import Account, CustomUser
from .models import  Group, Network, RootAuth, Post, GroupMembership, AddNetwork, NetworkPost, Making
from django.views import generic
from .forms import CreateClassForm, CreateNetworkForm, CreatePostForm, NetworkPostForm
from django.urls import reverse_lazy, reverse
from django.shortcuts import get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.db.models import Q
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
    networks = Network.objects.order_by('-pk')[:1000000]
    groups = Group.objects.order_by('-pk')[:100000000]
    # rootusers = RootAuth.objects.filter(user=request.user)
    posts = Post.objects.order_by('-pk')[:100000]
    account = Account.objects.get(pk=pk)
    # Accountモデルの全DBを取得する。
    accounts = Account.objects.order_by('-pk')[:100000]
    profile_user = get_object_or_404(CustomUser, pk=pk)
    rootauths = RootAuth.objects.filter(
        Q(user=request.user, target_user=profile_user) | 
        Q(user=profile_user, target_user=request.user),
        is_approved_by_user=True, 
        is_approved_by_target=True
    ).order_by('-pk')[:1000000]
    rootauths = RootAuth.objects.order_by('-pk')[:1000000]
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
    auth_requests_received = RootAuth.objects.filter(target_user=request.user, is_approved_by_user=False)
    add_network = AddNetwork.objects.filter(group__mainuser=account.mainuser, is_approved_by_target=False)
    return_requests = RootAuth.objects.filter(target_user=request.user, is_approved_by_target=False, is_approved_by_user=False, is_denied=True)
    context = {
        "csrf_token": "",
        "posts": posts,
        "accounts": accounts,
        "account" : account,
        "profile_user": profile_user,
        "auth_request_sent": auth_request_sent,
        "auth_requests_received": auth_requests_received,
        "mutual_auth": mutual_auth,
        "networks":networks,
        "groups":groups,
        "rootauths": rootauths,
        "add_network": add_network,
        "return_requests": return_requests,
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
    exists = AddNetwork.objects.filter(group=group, name__mainuser=user).order_by('-pk')[:100000000000]
    mutual_auth = AddNetwork.objects.filter(
        name__mainuser=request.user,
        group=group,
        is_approved_by_user=True, 
        is_approved_by_target=True
    ).exists() 
    # or AddNetwork.objects.filter(
    #         name__mainuser=request.user,
    #         group=group,
    #         is_approved_by_user=True, 
    #         is_approved_by_target=True
    #     ).exists()
    auth_requests_received = AddNetwork.objects.filter(group=group, is_approved_by_target=False)
    context = {
        "csrf_token": "",
        "posts": posts,
        "community": group,
        "accounts": accounts,
        "is_member":is_member,
        "groupmemberships": groupmemberships,
        "is_network": is_network,
        "networks": networks,
        "network_exists": network_exists,
        "exists": exists,
        "auth_requests_received": auth_requests_received,
        "mutual_auth": mutual_auth,
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
@login_required
def delete_network(request, name, pk):
    group = get_object_or_404(Group, name=name)
    network_name =get_object_or_404(Network,pk=pk)
    add_network = AddNetwork.objects.filter(name=network_name, group=group).exists()
    if add_network:
        exists_network = AddNetwork.objects.get(name=network_name, group=group)
        exists_network.delete()
    return redirect('community', name=name)
@login_required
def add_mark(request,name , pk):
    group = get_object_or_404(Group, name=name)
    network_name = get_object_or_404(Network, pk=pk)
    add_mark = Making.objects.filter(name=network_name, hub=network_name.hub, sub=group).exists()
    if not add_mark:
        Making.objects.create(name=network_name, hub=network_name.hub, sub=group)
    return redirect('network', pk=pk)
@login_required
def delete_mark(request,name , pk):
    group = get_object_or_404(Group, name=name)
    network_name = get_object_or_404(Network, pk=pk)
    add_mark = Making.objects.filter(name=network_name, hub=network_name.hub, sub=group).exists()
    if add_mark:
        exists_mark = Making.objects.get(name=network_name, hub=network_name.hub, sub=group)
        exists_mark.delete()
    return redirect('network', pk=pk)
    return redirect("page", pk=root.pk)
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
def network(request, pk):
    accounts = Account.objects.order_by('-pk')[:10000000]
    network = Network.objects.get(pk=pk)
    members = AddNetwork.objects.order_by('-pk')[:10000000]
    template = loader.get_template('net.html')
    posts = NetworkPost.objects.order_by('-pk')[:100000000000]
    user = request.user
    group = Group.objects.filter(mainuser=user).exists()
    is_network_name = AddNetwork.objects.filter(name=network, group__mainuser=user).exists()
    network_exists_mainuser = GroupMembership.objects.filter(account__mainuser=user, group=network.hub).exists()
    # is_members = 
    is_sub = Making.objects.filter(name=network, hub=network.hub).exists()
    marks = Making.objects.filter(hub=network.hub).order_by('-pk')[:1000000]
    enter_received = AddNetwork.objects.filter(name=network, group=group)
    context = {
        'csrf_token': '',
        'accounts': accounts,
        'network': network,
        "members": members,
        "is_network_name": is_network_name,
        "network_exists_mainuser": network_exists_mainuser,
        "posts": posts,
        "is_sub": is_sub,
        "marks": marks,
        "enter_received": enter_received,
    }
    if network.mainuser == request.user:
        return HttpResponse(template.render(context, request))
    if network.visibility == "local":
        # user = network.mainuser
        user = request.user
        can_join = network.can_user_join(user)
        if not can_join:
                return redirect('error') 
        else:
            return HttpResponse(template.render(context, request))
    # if network.visibility:
    #     if not network_exists_mainuser:
    #         return redirect('error') 
    #     else:
    #         return HttpResponse(template.render(context, request))
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
        'message':message,
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
class NetworkPostViews(generic.CreateView):
    form_class = NetworkPostForm
    template_name = "create-post.html"
    def get_form_kwargs(self, *args, **kwargs):
        kwargs = super().get_form_kwargs(*args, **kwargs)
        form = NetworkPostForm(self.request.FILES, self.request.POST, instance=Account and Network and AddNetwork)
        form.instance_name = self.kwargs['pk'] 
        kwargs['mainuser'] = self.request.user
        kwargs['destination'] = Network.objects.get(pk=form.instance_name)
        kwargs['username'] = Account.objects.get(name = self.request.user.username)
        kwargs['group'] = AddNetwork.objects.filter(name__pk=form.instance_name, group__mainuser=self.request.user)
        return kwargs
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        accounts = Account.objects.order_by('-pk')[:10000000]
        context['accounts'] = accounts       
        return context
    def get_success_url(self):
        return super().get_success_url()
form_network_post = NetworkPostViews.as_view()
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

    # リクエストが拒否されていた場合、そのステータスをリセット
    if auth_request.is_denied:
        auth_request.is_denied = False

    # リクエストを承認するロジック
    if request.user == auth_request.target_user and not auth_request.is_approved_by_target:
        auth_request.is_approved_by_target = True
        auth_request.is_approved_by_user = True
        auth_request.is_denied = False
        auth_request.save()

    elif request.user == auth_request.user and not auth_request.is_approved_by_user:
        auth_request.is_approved_by_user = True
        auth_request.is_approved_by_target = True
        auth_request.is_denied = False
        auth_request.save()

    # 相手からのリクエストも承認するロジックを追加
    reverse_request = RootAuth.objects.filter(user=auth_request.target_user, target_user=auth_request.user).first()
    if reverse_request:
        reverse_request.is_approved_by_user = True
        reverse_request.is_approved_by_target = True
        auth_request.is_denied = False
        reverse_request.save()

    return redirect('page', pk=request.user.id)

# @login_required
# def approve_auth_request(request, pk):
#     """認証リクエストを承認するビュー"""
#     auth_request = get_object_or_404(RootAuth, pk=pk)

#     # ユーザーがリクエストの送信者または受信者であるかを確認
#     if request.user == auth_request.target_user and not auth_request.is_approved_by_target:
#         auth_request.is_approved_by_target = True
#         auth_request.is_approved_by_user = True
#         auth_request.save()
#         # 相手からのリクエストも承認するロジックを追加
#         reverse_request = RootAuth.objects.filter(user=auth_request.target_user, target_user=auth_request.user).first()
#         if reverse_request:
#             reverse_request.is_approved_by_user = True
#             reverse_request.is_approved_by_target = True
#             reverse_request.save()

#     elif request.user == auth_request.user and not auth_request.is_approved_by_user:
#         auth_request.is_approved_by_user = True
#         auth_request.is_approved_by_target = True
#         auth_request.save()

#         # 相手からのリクエストも承認するロジックを追加
#         reverse_request = RootAuth.objects.filter(user=auth_request.target_user, target_user=auth_request.user).first()
#         if reverse_request:
#             reverse_request.is_approved_by_target = True
#             reverse_request.is_approved_by_user = True
#             reverse_request.save()

#     return redirect('page', pk=request.user.id)
@login_required
def return_auth_request(request, auth_pk):
    return_auth = get_object_or_404(RootAuth, pk=auth_pk)
    existing_auth  = RootAuth.objects.filter(user=return_auth.user, target_user=return_auth.target_user).first()
    if existing_auth:
       existing_auth.is_approved_by_user = True
       existing_auth.is_approved_by_target = True
       existing_auth.is_denied = False
       existing_auth.save()
    else:
        # 新しいリクエストを作成
        RootAuth.objects.create(
            user=return_auth.user,
            target_user=return_auth.target_user,
            is_approved_by_user=True,
            is_approved_by_target=True,
            is_denied=False
        )

    return redirect('page', pk=return_auth.target_user.pk)
# @login_required
# def not_approve_auth_request(request, pk):
#     not_approve_auth_request = get_object_or_404(RootAuth, pk=pk)
#         # リクエストを拒否状態に変更する（削除する場合は `delete()` を使用）
#     if request.user == not_approve_auth_request.target_user and not not_approve_auth_request.is_approved_by_target:
#         not_approve_auth_request.is_approved_by_target = False
#         not_approve_auth_request.save()
#         reverse_request = RootAuth.objects.filter(user=not_approve_auth_request.target_user, target_user=not_approve_auth_request.user).first()
#         if reverse_request:
#             reverse_request.is_approved_by_user = True
#             reverse_request.save()
#     elif request.user == not_approve_auth_request.user and not not_approve_auth_request.is_approved_by_user:
#         not_approve_auth_request.is_approved_by_user = True
#         not_approve_auth_request.save()
        
#         reverse_request = RootAuth.objects.filter(user=not_approve_auth_request.target_user, target_user=not_approve_auth_request.user).first()
#         if reverse_request:
#             reverse_request.is_approved_by_target = False
#             reverse_request.save()
#     return redirect('page', pk=request.user.id)
@login_required
def not_approve_auth_request(request, pk):
    not_approve_auth_request = get_object_or_404(RootAuth, pk=pk)

    # リクエストを拒否状態に変更する
    if request.user == not_approve_auth_request.target_user and not not_approve_auth_request.is_approved_by_target:
        not_approve_auth_request.is_approved_by_user = True
        not_approve_auth_request.is_approved_by_target = False
        not_approve_auth_request.is_denied = True  # 拒否状態に設定
        not_approve_auth_request.save()

        reverse_request = RootAuth.objects.filter(user=not_approve_auth_request.target_user, target_user=not_approve_auth_request.user).first()
        if reverse_request:
            reverse_request.is_approved_by_user = True
            reverse_request.save()

    elif request.user == not_approve_auth_request.user and not not_approve_auth_request.is_approved_by_user:
        not_approve_auth_request.is_approved_by_user = True
        reverse_request.is_approved_by_target = False
        not_approve_auth_request.is_denied = True  # 拒否状態に設定
        not_approve_auth_request.save()

        reverse_request = RootAuth.objects.filter(user=not_approve_auth_request.target_user, target_user=not_approve_auth_request.user).first()
        if reverse_request:
            reverse_request.is_approved_by_target = False
            reverse_request.save()

    return redirect('page', pk=request.user.id)

@login_required
def add_root(request, pk):
    add_root = get_object_or_404(RootAuth, pk=pk)
    if request.user == add_root.user and not add_root.is_approved_by_user:
        add_root.is_approved_by_user = True
        add_root.save()
        reverse_request = RootAuth.objects.filter(user=add_root.target_user, target_user=add_root.user).first()
        if reverse_request:
            reverse_request.is_approved_by_user = True
            reverse_request.save()
    elif request.user == add_root.target_user and not add_root.is_approved_by_user:
        add_root.is_approved_by_user = True
        add_root.save()
        
        reverse_request = RootAuth.objects.filter(user=add_root.target_user, target_user=add_root.user).first()
        if reverse_request:
            reverse_request.is_approved_by_user = False
            reverse_request.save()
    return redirect('page', pk=request.user.id)
@login_required
def approve_add_request(request, pk):
    """認証リクエストを承認するビュー"""
    auth_request = get_object_or_404(AddNetwork, pk=pk)

    # ユーザーがリクエストの送信者または受信者であるかを確認
    #ログインユーザーとAddNetworkモデルの引数group(Groupモデルのmainuser)の持つアドレスと一致とis_approved_by_targetが存在してないかどうかを判定。
    if request.user == auth_request.group.mainuser and not auth_request.is_approved_by_target:
        #もし、存在してないのであれば、is_approved_by_target=Trueで保存する。
        auth_request.is_approved_by_target = True
        auth_request.save()
        # 相手からのリクエストも承認するロジックを追加
        #AddNetworkの下で、引数nameが対象のNetworkのmainuserと一致しているもの(引数groupも同様)で絞り込み。
        reverse_request = AddNetwork.objects.filter(name__mainuser=auth_request.name.mainuser, group__mainuser=auth_request.group.mainuser).first()
        if reverse_request:
            #もし、上のAddNetworkが存在していればis_approved_by_user=Trueとして保存する。
            reverse_request.is_approved_by_user = True
            reverse_request.save()
    #ログインユーザーとAddNetworkモデルの引数group(Groupモデルのmainuser)の持つアドレスと一致とis_approved_by_userが存在してない時の処理
    elif request.user == auth_request.name.mainuser and not auth_request.is_approved_by_user:
        #もし、存在してないのであれば、is_approved_by_user=Trueで保存する
        auth_request.is_approved_by_user = True
        auth_request.save()

        # 相手からのリクエストも承認するロジックを追加
        #上のコードと同じで、AddNetworkの下で引数nameのmainuserと対象のNetworkのmainuserと一致しているもの(引数groupも同様)で絞り込み。
        reverse_request = AddNetwork.objects.filter(name__mainuser=auth_request.name.mainuser, group__mainuser=auth_request.group.mainuser).first()
        if reverse_request:
            #もし、絞り込みで存在していたらis_approved_by_target=Trueで保存。
            reverse_request.is_approved_by_target = True
            reverse_request.save()

    return redirect('page', pk=request.user.id)
@login_required
def not_approve_add_request(request, pk):
    not_approve_auth_request = get_object_or_404(AddNetwork, pk=pk)
    #ログインしてるユーザーとAddNetworkの引数groupのmainuserと一致していて、is_approved_by_targetがないのであれば、以下の処理を行う。
    if request.user == not_approve_auth_request.group.mainuser and not not_approve_auth_request.is_approved_by_target:
        #存在してないのであれば、is_approved_by_target=Trueで保存
        not_approve_auth_request.is_approved_by_target = True
        not_approve_auth_request.save()
        #AddNetworkの下で、引数nameが対象のNetworkのmainuserと一致しているもの(引数groupも同様)で絞り込み。
        reverse_request = AddNetwork.objects.filter(name__mainuser=not_approve_auth_request.name.mainuser, group__mainuser=not_approve_auth_request.group.mainuser).first()
        if reverse_request:
            #もし、絞り込みで存在しているときis_approved_by_user=Falseで保存。
            reverse_request.is_approved_by_user = False
            reverse_request.save()
    #ログインしているユーザーとAddNetworkの引数groupのmainuserと一致して、is_approved_by_userがないのであれば、以下の処理を行う。
    elif request.user == not_approve_auth_request.name.mainuser and not not_approve_auth_request.is_approved_by_user:
        #もしあれば、is_approved_by_user=Trueで保存。
        not_approve_auth_request.is_approved_by_user = True
        not_approve_auth_request.save()
        #AddNetworkの下で、引数nameが対象のNetworkのmainuserと一致しているもの(引数groupも同様)で絞り込み。
        reverse_request = AddNetwork.objects.filter(name__mainuser=not_approve_auth_request.name.mainuser, group__mainuser=not_approve_auth_request.group.mainuser).first()
        if reverse_request:
            #もし、上の引数も存在していたらis_approved_by_target=Falseで保存する。
            reverse_request.is_approved_by_target = False
            reverse_request.save()
    return redirect('page', pk=request.user.id)