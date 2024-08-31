from accounts.models import Account
from .models import Group
from django import forms
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