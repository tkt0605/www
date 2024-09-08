from accounts.models import Account
from .models import Group, Network, Post, RootAuth
from django import forms
from django.db.models import Q
class CreateClassForm(forms.ModelForm):
    class Meta:
        model = Group
        fields = "__all__"
        exclude = ["mainuser", "managername", "transaction_hash"]
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
            'explain': forms.Textarea(
                attrs={
                    "class": "explain",
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
            'root':forms.TextInput(
                attrs={
                    'placeholder': '@(Your Approach class)',
                }
            ),
        }
        required=True
    def __init__(self, mainuser=None, managername=None, *args, **kwargs):
        self.mainuser = mainuser
        self.managername = managername
        super().__init__(*args, **kwargs)
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

# class CreateNetworkForm(forms.ModelForm):
#     class Meta:
#         model = Network
#         fields =  "__all__"
#         exclude = ["mainuser", "managername"]
#         widgets = {
#             "name": forms.TextInput(
#                 attrs={
#                     "placeholder": "ネットワーク名",
#                     "class": "network_name",
#                 }
#             ),
#             "visibility": forms.RadioSelect(
#                 attrs={
#                     "class": "radio-point"
#                 }
#             ),
#         }
#     def __init__(self, mainuser=None,managername=None , *args, **kwargs):
#         self.mainuser = mainuser
#         self.managername = managername
#         super().__init__(*args, **kwargs)
#         if self.mainuser:
#             self.fields['mygroup'].queryset = Group.objects.filter(mainuser=self.mainuser)
#         if self.mainuser:
#             # mainuserと相互に認証されているユーザーのリストを取得
#             mutual_auth_users = RootAuth.objects.filter(
#                 Q(user=self.mainuser,target_user=self.managername , is_approved_by_user=True, is_approved_by_target=True) |
#                 Q(user=self.managername, target_user=self.mainuser, is_approved_by_user=True, is_approved_by_target=True)
#             )
#             # 認証済みユーザーが管理するグループをフィルタリング
#             self.fields['target_group'].queryset = Group.objects.filter(mainuser__in=mutual_auth_users)
#     def save(self, commit=True):
#         kwargs = super().save(commit=False)
#         if self.mainuser:
#             kwargs.mainuser = self.mainuser
#             kwargs.managername = self.managername
#             if commit == True:
#                 kwargs.save()
#                 self.save_m2m() 
#         return kwargs.mainuser
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
        