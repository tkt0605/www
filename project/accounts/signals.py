import os
import json
import logging
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth import get_user_model
from .models import Account, CustomUser
from web3 import Web3
from django.conf import settings
from django.contrib import messages
User = get_user_model()
@receiver(post_save, sender=get_user_model())
def create_user_account(sender, instance, created, **kwargs):
    if created:
        Account.objects.create(mainuser=instance, name=instance.username)