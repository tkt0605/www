# Generated by Django 5.1 on 2024-10-11 09:51

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0063_remove_group_comanager_alter_rootauth_target_user_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='comanager',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='rootauths', to='flexblock.rootauth'),
        ),
    ]
