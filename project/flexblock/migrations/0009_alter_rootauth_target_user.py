# Generated by Django 5.1 on 2024-09-05 00:50

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0008_alter_rootauth_target_user'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AlterField(
            model_name='rootauth',
            name='target_user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auth_requests_received', to=settings.AUTH_USER_MODEL),
        ),
    ]
