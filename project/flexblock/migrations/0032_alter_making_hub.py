# Generated by Django 5.1 on 2024-09-18 12:20

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0031_alter_making_hub'),
    ]

    operations = [
        migrations.AlterField(
            model_name='making',
            name='hub',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='ハブグループ', to='flexblock.group'),
        ),
    ]
