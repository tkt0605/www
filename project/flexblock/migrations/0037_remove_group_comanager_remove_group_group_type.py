# Generated by Django 5.1 on 2024-09-23 21:14

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0036_remove_group_comanager_group_comanager'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='group',
            name='comanager',
        ),
        migrations.RemoveField(
            model_name='group',
            name='group_type',
        ),
    ]
