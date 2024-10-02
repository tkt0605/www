# accounts/admin.py

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser, Account
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth import get_user_model
# class CustomUserAdmin(UserAdmin):
#     model = CustomUser
#     list_display = ('email', 'username', 'first_name', 'last_name', 'is_staff', 'is_active')
#     list_filter = ('email', 'is_staff', 'is_active')
#     fieldsets = (
#         (None, {'fields': ('email', 'password')}),
#         ('Personal info', {'fields': ('username', 'first_name', 'last_name')}),
#         ('Permissions', {'fields': ('is_staff', 'is_active', 'is_superuser', 'groups', 'user_permissions')}),
#         ('Important dates', {'fields': ('last_login', 'date_joined')}),
#     )
#     add_fieldsets = (
#         (None, {
#             'classes': ('wide',),
#             'fields': ('email', 'username','first_name', 'last_name', 'password1', 'password2', 'is_staff', 'is_active')},
#         ),
#     )
#     search_fields = ('email',)
#     ordering = ('email',)
#     # inlines = [AccountInline]  # ここにインラインを追加

# admin.site.register(CustomUser, CustomUserAdmin)

# User = get_user_model()
# class AccountInline(admin.StackedInline):
#     model = Account
#     can_delete = False
#     verbose_name_plural = 'profiles'
# class UserAdmin(BaseUserAdmin):
#     inlines = (AccountInline,)

# admin.site.unregister(User)
# admin.site.register(User, UserAdmin)
# User = get_user_model()
class AccountInline(admin.StackedInline):
    model = Account
    can_delete = False
    verbose_name_plural = 'profiles'

class CustomUserAdmin(BaseUserAdmin):
    model = CustomUser
    list_display = ('email', 'username', 'first_name', 'last_name', 'is_staff', 'is_active')
    list_filter = ('email', 'is_staff', 'is_active')
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Personal info', {'fields': ('username', 'first_name', 'last_name')}),
        ('Permissions', {'fields': ('is_staff', 'is_active', 'is_superuser', 'groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login', 'date_joined')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'username', 'first_name', 'last_name', 'password1', 'password2', 'is_staff', 'is_active')},
        ),
    )
    search_fields = ('email',)
    ordering = ('email',)
    inlines = [AccountInline]  # AccountInlineを追加
# admin.site.unregister(User)
admin.site.register(CustomUser, CustomUserAdmin)
