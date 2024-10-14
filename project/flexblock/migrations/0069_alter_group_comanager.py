# Generated by Django 5.1 on 2024-10-13 12:35

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0068_alter_group_comanager'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='comanager',
            field=models.ManyToManyField(blank=True, related_name='rootauths', to=settings.AUTH_USER_MODEL),
        ),
    ]
