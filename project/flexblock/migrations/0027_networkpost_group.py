# Generated by Django 5.1 on 2024-09-16 10:14

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0026_making'),
    ]

    operations = [
        migrations.AddField(
            model_name='networkpost',
            name='group',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='flexblock.group', verbose_name='管理元'),
        ),
    ]