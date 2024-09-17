# from django.db.models.signals import post_save
# from django.dispatch import receiver
# from django.contrib.auth import get_user_model
# from .models import Network, AddNetwork
# @receiver(post_save, sender=Network)
# def create_user_account(sender, instance, created, **kwargs):
#     if created:
#         AddNetwork.objects.create(name=instance, group=instance.hub)
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth import get_user_model
from .models import Network, AddNetwork

@receiver(post_save, sender=Network)
def create_user_account(sender, instance, created, **kwargs):
    if created:
        # Networkインスタンスが作成されたときにAddNetworkを作成
        AddNetwork.objects.create(name=instance, group=instance.hub)

