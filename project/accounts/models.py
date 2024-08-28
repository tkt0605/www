from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models
from django.utils import timezone
from django.conf import settings

class CustomUserManager(BaseUserManager):
    def create_user(self, email, username=None, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, username=None, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(email, username, password, **extra_fields)

class CustomUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=30, unique=True, default='default_username')
    first_name = models.CharField(max_length=30, blank=True)
    last_name = models.CharField(max_length=30, blank=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    date_joined = models.DateTimeField(default=timezone.now)
    objects = CustomUserManager()
    blockchain_address = models.CharField(max_length=66, blank=True, null=True)  
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.email
    @property
    def profile(self):
        return Account.objects.get_or_create(user=self)[0]
class Account(models.Model):
    mainuser = models.OneToOneField(CustomUser, on_delete=models.CASCADE, verbose_name="メインユーザー", blank=True, null=True, default="")
    name = models.CharField(max_length=15, verbose_name='ユーザー名', blank=True, null=True, default="")
    image = models.ImageField(upload_to='media/image/', verbose_name="バックイメージ", default='image/sample.jpg')
    icon = models.ImageField(upload_to='media/icon/', verbose_name="アイコン",  default='icon/5770f01a32c3c53e90ecda61483ccb08.jpg')
    infomation = models.TextField(max_length=180, verbose_name="紹介文",blank=True, null=True, default="・・・・")
    hobby =  models.CharField(max_length=8, default="・・・・")
    detail = models.CharField(max_length=8, default="・・・・")
    hash = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True,null=True  ,verbose_name='作成日')
    def __str__(self):
        return str(self.name)
    class Meta:
        verbose_name_plural = 'Account'