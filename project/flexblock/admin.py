from django.contrib import admin
from .models import Group,RootAuth, Post, GroupMembership, Network, AddNetwork
admin.site.register(Group)
admin.site.register(Network)
admin.site.register(RootAuth)
admin.site.register(Post)
admin.site.register(GroupMembership)
admin.site.register(AddNetwork)