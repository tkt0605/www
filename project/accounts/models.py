from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin, Group, Permission
from django.db import models
from django.utils import timezone
from django.conf import settings
from django.db.models import Q # 遅延インポート
# class CustomUserManager(BaseUserManager):
#     def create_user(self, email, username, first_name, last_name, password=None, **extra_fields):
#         if not email:
#             raise ValueError('The Email field must be set')
#         email = self.normalize_email(email)
#         user = self.model(email=email, username=username, first_name=first_name, last_name=last_name, **extra_fields)
#         user.set_password(password)
#         user.save(using=self._db)
#         return user

#     def create_superuser(self, email, username,first_name, last_name, password, **extra_fields):
#         extra_fields.setdefault('is_staff', True)
#         extra_fields.setdefault('is_superuser', True)
#         return self.create_user(email, username,first_name, last_name, password, **extra_fields)
class CustomUserManager(BaseUserManager):
    def create_user(self, email, username, first_name, last_name, password=None):
        if not email:
            raise ValueError("Users must have an email address")
        if not first_name:
            raise ValueError("Users must have a first name")
        if not last_name:
            raise ValueError("Users must have a last name")
        
        email = self.normalize_email(email)
        user = self.model(email=email, username=username, first_name=first_name, last_name=last_name)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, username, first_name, last_name, password):
        user = self.create_user(email, username, first_name, last_name, password)
        user.is_admin = True
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user
class CustomUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=30, unique=True, default='default_username')
    first_name = models.CharField(max_length=30, blank=True, null=False, default="NoFirstName")
    last_name = models.CharField(max_length=30, blank=True, null=False, default="NoLastName")
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    date_joined = models.DateTimeField(default=timezone.now)
    objects = CustomUserManager()
    groups = models.ManyToManyField(
        Group,
        related_name='custom_user_groups', 
        blank=True,
        help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.',
        related_query_name='user',
    )
    user_permissions = models.ManyToManyField(
        Permission,
        related_name='custom_user_permissions', 
        blank=True,
        help_text='Specific permissions for this user.',
        related_query_name='user',
    )
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'first_name', 'last_name']
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
    created_at = models.DateTimeField(auto_now_add=True,null=True,verbose_name='作成日')

    def __str__(self):
        return str(self.name)

    class Meta:
        verbose_name_plural = 'Account'
