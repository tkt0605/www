from django.db import models
from django.contrib.auth import get_user_model
from accounts.models import CustomUser, Account
User = get_user_model()
class Category(models.Model):
    name = models.CharField('カテゴリー', max_length=100)

    def __str__(self):
        return self.name
class Group(models.Model):
    mainuser = models.ForeignKey("accounts.CustomUser",  on_delete=models.PROTECT, verbose_name="メインユーザー", blank=True, null=True)
    managername = models.ForeignKey(Account, null=True,on_delete=models.CASCADE,verbose_name="管理者")
    name = models.CharField(max_length=30, blank=True, null=True, verbose_name="Class名")
    category=models.CharField(max_length=15, blank=False, null=True, verbose_name="カテゴリ")
    web_site = models.URLField(blank=True)
    backimage = models.ImageField(upload_to='backimage/', verbose_name="BackImage")
    icon = models.ImageField(upload_to='classicon/', verbose_name="クラスアイコン", null=True)
    index = models.CharField(max_length=50, blank=False, null=True, verbose_name = "見出し")
    explain = models.TextField(max_length=180, blank=True, verbose_name="explain")
    transaction_hash = models.CharField(max_length=66, blank=True, null=True)
    created_at = models.DateField(null=True ,auto_now_add=True, blank=True, verbose_name='作成日')
    def __str__(self):
        return str(self.name)
    class Meta:
        verbose_name_plural = 'ClassName'
class Post(models.Model):
    mainuser = models.ForeignKey("accounts.CustomUser", on_delete=models.PROTECT, verbose_name="メインユーザー", blank=True, null=True)
    destination = models.ForeignKey(Group, on_delete=models.CASCADE, verbose_name="投稿先")
    username = models.ForeignKey(Account, null=True,on_delete=models.CASCADE,verbose_name="投稿主")
    text = models.TextField(null=True, verbose_name=None)
    image = models.FileField(upload_to='post/',null=True,blank=True , verbose_name=None)
    video = models.FileField(upload_to='video/', null=True, blank=True, verbose_name=None)
    created_at = models.DateTimeField(auto_now_add=True,null=True  ,verbose_name='作成日')
    def __str__(self):
        return str(self.text)
    class Meta:
        verbose_name_plural = "Post"