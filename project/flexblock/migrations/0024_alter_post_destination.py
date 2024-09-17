# Generated by Django 5.1 on 2024-09-15 23:51

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0023_network_hub'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post',
            name='destination',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='flexblock.network', verbose_name='投稿先'),
        ),
    ]