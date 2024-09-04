from django.contrib import admin
from .models import Group, Network, RootAuth
admin.site.register(Group)
admin.site.register(Network)
admin.site.register(RootAuth)