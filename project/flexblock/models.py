from django.db import models
from django.contrib.auth import get_user_model
from accounts.models import CustomUser, Account
from django.urls import reverse_lazy, reverse
from django.db.models import Q
User = get_user_model()
class RootAuth(models.Model):
    user = models.ForeignKey(Account, related_name='auth_requests_sent', on_delete=models.CASCADE, blank=True, null=True)
    target_user = models.ForeignKey(Account, related_name='auth_requests_received', on_delete=models.CASCADE, blank=True, null=True)
    is_approved_by_user = models.BooleanField(default=False)
    is_approved_by_target = models.BooleanField(default=False)
    is_denied = models.BooleanField(default=False) 
    class Meta:
        unique_together = ('user', 'target_user')
    def approve(self, by_user):
        """相互認証の承認処理"""
        if by_user == self.user:
            self.is_approved_by_user = True
        elif by_user == self.target_user:
            self.is_approved_by_target = True
        self.save()
        return self.is_approved_by_user and self.is_approved_by_target

    def is_fully_approved(self):
        """両者による承認の完了状態を確認"""
        return self.is_approved_by_user and self.is_approved_by_target

    def __str__(self):
        return f"{self.user}"
class Group(models.Model):
    VISIBILITY_CHOICES = [
        ('public', 'Public'),
        ('local', 'Local'),
    ]
    GROUP_TYPE = [
        ('single', 'シングル'),
        ('multiple', 'マルチ'),
    ]
    mainuser = models.ForeignKey(CustomUser,  on_delete=models.PROTECT, verbose_name="メインユーザー", blank=True, null=True)
    managername = models.ForeignKey(Account, null=True,on_delete=models.CASCADE,verbose_name="管理者",  blank=True,)
    type = models.CharField(max_length=10,choices=GROUP_TYPE,default='single',verbose_name="タイプ")
    # mainusers = models.ForeignKey(CustomUser, related_name="共同管理者", blank=True)
    comanager = models.ManyToManyField(RootAuth, related_name="rootauths", blank=True)
    # comanager = models.ForeignKey(Account, related_name="rootauths",on_delete=models.CASCADE, blank=True, null=True)
    name = models.CharField(max_length=30, blank=True, null=True,unique=True , verbose_name="Class名")
    category=models.CharField(max_length=15, blank=False, null=True, verbose_name="カテゴリ")
    visibility = models.CharField(max_length=10,choices=VISIBILITY_CHOICES,default='public',verbose_name="可視性")
    web_site = models.TextField(blank=True, help_text="複数のURLを@で区切って入力してください")
    backimage = models.ImageField(upload_to='backimage/', verbose_name="BackImage")
    index = models.CharField(max_length=100, blank=False, null=True, verbose_name = "見出し")
    created_at = models.DateField(null=True ,auto_now_add=True, blank=True, verbose_name='作成日')
    def __str__(self):
        return str(self.name)
    def can_user_join(self, user):
        """指定されたユーザーがグループに参加できるか確認"""
        # もしグループが'local'な場合、追加のチェックを実行
        manager_user = self.managername.user if hasattr(self.managername, 'user') else None
        main_user = self.mainuser
        if self.visibility == 'local' and self.type == 'single':
            # 管理者またはメインユーザーによる許可を確認
            is_approved_by_manager = RootAuth.objects.filter(
                user=manager_user, target_user=user, is_approved_by_user=True, is_approved_by_target=True
            ).exists() 
            is_approved_by_mainuser = RootAuth.objects.filter(
                user=main_user, target_user=user, is_approved_by_user=True, is_approved_by_target=True
            ).exists()
            is_approved_by_manager_login = RootAuth.objects.filter(
                user=user, target_user=manager_user, is_approved_by_user=True, is_approved_by_target=True
            ).exists() 
            is_approved_by_mainuser_login = RootAuth.objects.filter(
                user=user, target_user=main_user, is_approved_by_user=True, is_approved_by_target=True
            ).exists()
            
            # グループに参加できる条件は、管理者またはメインユーザーによる許可
            if not (is_approved_by_manager or is_approved_by_mainuser or is_approved_by_manager_login or is_approved_by_mainuser_login):
                return False
            # 通常のグループ参加条件（RootAuthの相互承認をチェック
        auth_exists = RootAuth.objects.filter(
            Q(user=main_user, target_user=user) | 
            Q(user=user, target_user=main_user),
            is_approved_by_user=True,
            is_approved_by_target=True
        ).exists()
        print(f"Auth from mainuser to user: {auth_exists}")
        # 'local'の場合の追加条件も満たしていれば、参加可能
        return auth_exists
    def multiple_user_join(self, user):
        if self.visibility == 'local' and self.type == 'multiple':
            comanagers = self.comanager.all()
            # comanagers = Group.objects.filter(name=self.name).values_list('comanager', flat=True).all()
            for co_manager in comanagers:
                is_approved_by_manager = RootAuth.objects.filter(
                    user=co_manager.mainuser, target_user=user, is_approved_by_user=True, is_approved_by_target=True, is_denied=False
                ).exists() 
                is_approved_by_manager_login = RootAuth.objects.filter(
                    user=user, target_user=co_manager.mainuser, is_approved_by_user=True, is_approved_by_target=True, is_denied=False
                ).exists()
                if is_approved_by_manager  or is_approved_by_manager_login:
                    return True
            return False
        if self.mainuser:
            multiple_auth_user = RootAuth.objects.filter(
                Q(user=self.mainuser, target_user=user) | 
                Q(user=user, target_user=self.mainuser),
                is_approved_by_user=True,
                is_approved_by_target=True
            ).exists()
            print(f"Auth from mainuser to user: {multiple_auth_user}")
            return multiple_auth_user
        return False
    def get_absolute_url(self):
        return reverse('community', kwargs={"name": self.name})
    class Meta:
            verbose_name_plural = 'ClassName'
class GroupMembership(models.Model):
    # account = models.ForeignKey("accounts.CustomUser", on_delete=models.CASCADE, verbose_name="ユーザー名", null=True)
    account = models.ForeignKey(Account, on_delete=models.CASCADE, verbose_name="ユーザー名", null=True)
    group = models.ForeignKey(Group or CoGroup, on_delete=models.CASCADE, verbose_name='参加グループ名', null=True)
    join_date = models.DateTimeField(auto_now_add=True, null=True, verbose_name="参加日")
    class Meta:
        unique_together = ('account', 'group')  # 同じユーザーが同じグループに重複して参加できないようにする

    def __str__(self):
        return f'{self.account.name} joined {self.group.name}'
class Post(models.Model):
    mainuser = models.ForeignKey("accounts.CustomUser", on_delete=models.PROTECT, verbose_name="メインユーザー", blank=True, null=True)
    destination = models.ForeignKey(Group or CoGroup, on_delete=models.CASCADE, verbose_name="投稿先")
    username = models.ForeignKey(Account, null=True,on_delete=models.CASCADE,verbose_name="投稿主")
    text = models.TextField(null=True, verbose_name=None)
    image = models.FileField(upload_to='post/',null=True,blank=True , verbose_name=None)
    video = models.FileField(upload_to='video/', null=True, blank=True, verbose_name=None)
    created_at = models.DateTimeField(auto_now_add=True,null=True  ,verbose_name='作成日')
    def __str__(self):
        return str(self.text)
    def get_absolute_url(self):
        return reverse('community', name=self.destination)
    class Meta:
        verbose_name_plural = "Post"
class Network(models.Model):
    VISIBILITY_CHOICES = [
        ('public', 'Public'),
        ('local', 'Local'),
    ]
    mainuser = models.ForeignKey("accounts.CustomUser", on_delete=models.PROTECT, verbose_name="メインユーザー", blank=True, null=True)
    hub = models.ForeignKey(Group, on_delete=models.CASCADE, null=True, blank=True, related_name="ハブグループ名")
    name = models.CharField(max_length=30, blank=True, null=True,unique=True , verbose_name="Network名")
    visibility = models.CharField(max_length=10, choices=VISIBILITY_CHOICES, default='public', verbose_name="可視性")
    image = models.FileField(upload_to='classicon/', null=True, blank=True, verbose_name=None)
    index = models.CharField(max_length=50, blank=False, null=True, verbose_name="見出し")
    created_at = models.DateTimeField(null=True, auto_now_add=True, blank=True, verbose_name='作成日')
    def __str__(self):
        return str(self.name)
    def multiple_user_join(self, user):
        if self.visibility == 'local' and self.hub.type == 'multiple':
            comanagers = self.hub.comanager.all()
            # comanagers = Group.objects.filter(name=self.name).values_list('comanager', flat=True).all()
            for co_manager in comanagers:
                is_approved_by_manager = RootAuth.objects.filter(
                    user=co_manager.mainuser, target_user=user, is_approved_by_user=True, is_approved_by_target=True, is_denied=False
                ).exists() 
                is_approved_by_manager_login = RootAuth.objects.filter(
                    user=user, target_user=co_manager.mainuser, is_approved_by_user=True, is_approved_by_target=True, is_denied=False
                ).exists()
                if is_approved_by_manager  or is_approved_by_manager_login:
                    return True
            return False
        if self.mainuser:
            multiple_auth_user = RootAuth.objects.filter(
                Q(user=self.mainuser, target_user=user) | 
                Q(user=user, target_user=self.mainuser),
                is_approved_by_user=True,
                is_approved_by_target=True
            ).exists()
            print(f"Auth from mainuser to user: {multiple_auth_user}")
            return multiple_auth_user
        return False
    def can_user_join(self, user):
        """指定されたユーザーがグループに参加できるか確認"""
        # もしグループが'local'な場合、追加のチェックを実行
        manager_user = self.hub.managername.user if hasattr(self.hub.managername, 'user') else None
        main_user = self.mainuser
        if self.visibility == 'local':
            # 管理者またはメインユーザーによる許可を確認
            is_approved_by_manager = RootAuth.objects.filter(
                user=manager_user, target_user=user, is_approved_by_user=True, is_approved_by_target=True
            ).exists() 
            is_approved_by_mainuser = RootAuth.objects.filter(
                user=main_user, target_user=user, is_approved_by_user=True, is_approved_by_target=True
            ).exists()
            is_approved_by_manager_login = RootAuth.objects.filter(
                user=user, target_user=manager_user, is_approved_by_user=True, is_approved_by_target=True
            ).exists() 
            is_approved_by_mainuser_login = RootAuth.objects.filter(
                user=user, target_user=main_user, is_approved_by_user=True, is_approved_by_target=True
            ).exists()
            # グループに参加できる条件は、管理者またはメインユーザーによる許可
            if not (is_approved_by_manager or is_approved_by_mainuser or is_approved_by_manager_login or is_approved_by_mainuser_login):
                return False
            # 通常のグループ参加条件（RootAuthの相互承認をチェック）
        auth_exists = RootAuth.objects.filter(
            Q(user=main_user, target_user=user) | 
            Q(user=user, target_user=main_user),
            is_approved_by_user=True,
            is_approved_by_target=True
        ).exists()
        print(f"Auth from mainuser to user: {auth_exists}")
        # 'local'の場合の追加条件も満たしていれば、参加可能
        return auth_exists
    def get_success_url(self):
        return reverse('networks')
    class Meta:
        verbose_name_plural = 'Network'
class AddNetwork(models.Model):
    name = models.ForeignKey(Network, on_delete=models.CASCADE, null=True)
    group = models.ForeignKey(Group, on_delete=models.CASCADE, null=True)
    is_approved_by_user = models.BooleanField(default=False)
    is_approved_by_target = models.BooleanField(default=False)
    is_denied = models.BooleanField(default=False)
    # created_at = models.DateTimeField(null=True, auto_now_add=True, blank=True, verbose_name='作成日')
    class Meta:
        verbose_name_plural = "AddNetwork"
    def approve(self, by_user):
        """相互認証の承認処理"""
        if by_user == self.name:
            self.is_approved_by_user = True
        elif by_user == self.group:
            self.is_approved_by_target = True
        self.save()
        return self.is_approved_by_user and self.is_approved_by_target

    def is_fully_approved(self):
        """両者による承認の完了状態を確認"""
        return self.is_approved_by_user and self.is_approved_by_target

    def __str__(self):
        return f"{self.name}"
class NetworkPost(models.Model):
    mainuser = models.ForeignKey("accounts.CustomUser", on_delete=models.PROTECT, verbose_name="メインユーザー", blank=True, null=True)
    destination = models.ForeignKey(Network, on_delete=models.CASCADE, verbose_name="投稿先")
    group = models.ForeignKey(AddNetwork, on_delete=models.CASCADE, verbose_name="管理元", null=True)
    # group = models.ForeignKey(Group, on_delete=models.CASCADE, verbose_name="管理元", null=True)
    username = models.ForeignKey(Account, null=True,on_delete=models.CASCADE,verbose_name="投稿主")
    text = models.TextField(null=True, verbose_name=None)
    image = models.FileField(upload_to='post/',null=True,blank=True , verbose_name=None)
    video = models.FileField(upload_to='video/', null=True, blank=True, verbose_name=None)
    created_at = models.DateTimeField(auto_now_add=True,null=True  ,verbose_name='作成日')
    def __str__(self):
        return str(self.text)
    def get_absolute_url(self):
        return reverse("network", kwargs={"pk": self.destination.pk})
    class Meta:
        verbose_name_plural = "NetworkPost"
class Making(models.Model):
    name = models.ForeignKey(Network, on_delete=models.PROTECT, null=True, related_name="ネットワーク名")
    hub = models.ForeignKey(Group, on_delete=models.PROTECT, null=True, related_name="ハブグループ")
    sub = models.ForeignKey(Group, on_delete=models.PROTECT, null=True, related_name="サブグループ")
    created_at = models.DateTimeField(null=True, auto_now_add=True, blank=True, verbose_name='作成日')
    def __str__(self):
        return f"{self.name}⇔{self.hub}->{self.sub} "
    class Meta:
        verbose_name_plural = "Making"