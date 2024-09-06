from django.contrib import admin
from .models import Group, Network, RootAuth, Post, GroupMembership
admin.site.register(Group)
admin.site.register(Network)
admin.site.register(RootAuth)
admin.site.register(Post)
admin.site.register(GroupMembership)