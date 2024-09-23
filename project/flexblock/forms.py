from accounts.models import Account
from .models import Group, Network, Post, RootAuth, NetworkPost, AddNetwork
from django import forms
from django.db.models import Q
class CreateClassForm(forms.ModelForm):
    class Meta:
        model = Group
        fields = "__all__"
        exclude = ["mainuser", "managername"]
        required=True,
        disabled=False,
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
        required=True
    def __init__(self, mainuser=None, managername=None, *args, **kwargs):
        self.mainuser = mainuser
        self.managername = managername
        super().__init__(*args, **kwargs)
        if self.mainuser:
            self.fields['comanager'].queryset =  RootAuth.objects.filter(user=self.managername.mainuser, is_approved_by_user=True, is_approved_by_target=True)
    def save(self, commit=True):
        kwargs = super().save(commit=False)
        if self.mainuser:
            kwargs.mainuser = self.mainuser
            kwargs.managername = self.managername
            if commit == True:
                kwargs.save()
        return  kwargs.mainuser
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