from typing import Any, Mapping
from django.core.files.base import File
from django.db.models.base import Model
from django.forms.utils import ErrorList
from accounts.models import Account
from .models import Group, Network, Post, RootAuth, NetworkPost, AddNetwork
from django import forms
from django.db.models import Q
from django.core.exceptions import ValidationError
from django.core.validators import URLValidator
class CreateClassForm(forms.ModelForm):
    class Meta:
        model = Group
        fields = "__all__"
        exclude = ["mainuser", "managername", "mainusers"]    
        # required=True,
        # disabled=False,
        widgets = {
            'name': forms.TextInput(
                attrs={
                    "class": "name",
                    'placeholder': '名前（ドットは不可）',
                    "min-length": 8,
                }
            ),
            'category':forms.TextInput(
                attrs={
                    "class": "category",
                    "placeholder": "#カテゴリー",
                }
            ),
            'web_site': forms.TextInput(
                attrs={
                    "class":"web_site",
                    "placeholder": "@リンク",
                }
            ),
            'index': forms.TextInput(
                attrs={
                    "class": "index",
                    "placeholder": "@見出し",
                }
            ),
        }
    def __init__(self, mainuser=None, managername=None, mainusers=None, *args, **kwargs):
        self.mainuser = mainuser
        self.managername = managername
        self.mainusers = mainusers
        # self.comanager = comanager 
        super().__init__(*args, **kwargs)
        if self.instance.type == 'multiple':
            self.fields['comanager'].required = True  # 必須にする
            self.fields['managername'].required = False
        else:
            self.fields['comanager'].required = False# 非表示にする
    def clean_web_site(self):
        web_site = self.cleaned_data.get('web_site')

        if web_site:
            # @で区切ってリンクリストを作成し、先頭の@を削除

            link_list = [link.strip() for link in web_site.split('@') if link.strip()]
            url_validator = URLValidator()

            invalid_links = []
            valid_links = []
        
            # 各リンクをバリデーション
            for link in link_list:
                try:
                    # リンクがhttpまたはhttpsで始まっているか確認
                    if not (link.startswith('http://') or link.startswith('https://')):
                        raise ValidationError(f'{link} must start with http:// or https://')
                    # URLをバリデート
                    url_validator(link)
                    valid_links.append(link)  # 有効なリンクをリストに追加
                except ValidationError:
                    invalid_links.append(link)
            # 不正なリンクがある場合はエラーを返す
            if invalid_links:
                raise ValidationError(f'The following URLs are invalid: {", ".join(invalid_links)}')
            # リストを再び'@'で区切って返す
            return '@' + '@'.join(valid_links)
        # web_siteが存在しない場合はそのまま返す
        return web_site
    def save(self, commit=True):
        kwargs = super().save(commit=False)
        # mainuserとmanagernameの保存処理
        if self.mainuser:
            kwargs.mainuser = self.mainuser
        if self.managername:
            kwargs.managername = self.managername
        if commit:
            kwargs.save()
        # ManyToManyField の mainusers をセット
        if self.mainusers:
            kwargs.mainuser.set(self.mainusers)
        # commit=True ならばオブジェクトを保存してから返す
        if commit:
            kwargs.save()
        return kwargs  # オブジェクトそのものを返す
class CreateNetworkForm(forms.ModelForm):
    class Meta:
        model = Network
        fields = "__all__"
        exclude = ["mainuser"]
        widgets = {
            'name': forms.TextInput(
                attrs={
                    'placeholder': 'ネットワーク名を入力',
                    'class': 'network_name',
                }
            ),
            'visibility': forms.RadioSelect(
                attrs={
                    'class': 'radio-point'
                }
            ),
            'image': forms.ClearableFileInput(
                attrs={
                    'class': 'image-upload'
                }
            ),
            'index': forms.TextInput(
                attrs={
                    'placeholder': 'ネットワークの説明を入力',
                    'class': 'network_index',
                }
            ),
        }

    def __init__(self, mainuser=None, *args, **kwargs):
        self.mainuser = mainuser
        super().__init__(*args, **kwargs)
        if self.mainuser:
            self.fields['hub'].queryset = Group.objects.filter(mainuser=self.mainuser)
    def save(self, commit=True):
        kwargs = super().save(commit=False)
        if self.mainuser:
            kwargs.mainuser = self.mainuser  # mainuserをインスタンスに設定
        if commit:
            kwargs.save()  # データベースに保存
        return kwargs
class CreatePostForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = "__all__"
        exclude = ["mainuser", "destination", "username"]
        widgets = {
            "text": forms.Textarea(
                attrs = {
                    "class": "text-post",
                    "placeholder": "新規投稿",
                }
            ),
            "image": forms.FileInput(
                attrs={
                    "class": "image-post",
                }
            ),
            "vedio": forms.FileInput(
                attrs={
                    "class": "vedio-post",
                }
            )
        }
    def __init__(self, mainuser=None, destination=None, username=None, *args, **kwargs):
        self.mainuser = mainuser
        self.destination = destination    
        self.username = username
        super().__init__(*args, **kwargs)
    def save(self, commit=True):
        kwargs = super().save(commit=False)
        if self.mainuser:
            kwargs.mainuser = self.mainuser
            kwargs.destination = self.destination
            kwargs.username = self.username
            if commit:
                kwargs.save()
        return kwargs
class NetworkPostForm(forms.ModelForm):
    class Meta:
        model = NetworkPost
        fields = '__all__'
        exclude = ['mainuser', 'destination', 'username', 'group']
        widgets = {
            "text": forms.Textarea(
                attrs = {
                    "class": "text-post",
                    "placeholder": "新規投稿",
                }
            ),
            "image": forms.FileInput(
                attrs={
                    "class": "image-post",
                }
            ),
            "vedio": forms.FileInput(
                attrs={
                    "class": "vedio-post",
                }
            )
        }
    def __init__(self, mainuser=None, destination=None, username=None,group=None, *args, **kwargs):
        self.mainuser = mainuser
        self.destination = destination
        self.username = username
        self.group = group
        super().__init__(*args, **kwargs)
    def save(self, commit=True):
        kwargs = super().save(commit=False)
        if self.mainuser:
            kwargs.mainuser = self.mainuser
            kwargs.destination = self.destination
            kwargs.username = self.username
            kwargs.group = self.group.first()
            if commit:
                kwargs.save()
        return kwargs