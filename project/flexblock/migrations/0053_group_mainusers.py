# Generated by Django 5.1 on 2024-09-29 22:17

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0052_alter_group_type'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='group',
            name='mainusers',
            field=models.ManyToManyField(blank=True, related_name='メインユーザー', to=settings.AUTH_USER_MODEL),
        ),
    ]