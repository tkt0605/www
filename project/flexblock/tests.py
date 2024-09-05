from django.test import TestCase
from flexblock.models import RootAuth, CustomUser

# テストするユーザー
user1 = CustomUser.objects.get(id=1)
user2 = CustomUser.objects.get(id=2)

# RootAuthのインスタンスを作成
root_auth, created = RootAuth.objects.get_or_create(user=user1, target_user=user2)

print(f"RootAuth created: {created}, Initial state: {root_auth.is_approved_by_user}, {root_auth.is_approved_by_target}")

# ユーザー1による承認
root_auth.approve(user1)
print(f"After user1 approval: {root_auth.is_approved_by_user}, {root_auth.is_approved_by_target}")

# ユーザー2による承認
root_auth.approve(user2)
print(f"After user2 approval: {root_auth.is_approved_by_user}, {root_auth.is_approved_by_target}")

print(f"Is fully approved: {root_auth.is_fully_approved()}")
