# Generated by Django 5.1 on 2024-09-03 00:19

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Network',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=30, null=True, verbose_name='ネットワーク名')),
                ('image', models.FileField(blank=True, null=True, upload_to='classicon/')),
                ('index', models.CharField(max_length=50, null=True, verbose_name='見出し')),
                ('created_at', models.DateTimeField(auto_now_add=True, null=True, verbose_name='作成日')),
                ('mainteam', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='作成クラス', to='flexblock.group')),
                ('mainuser', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='メインユーザー', to=settings.AUTH_USER_MODEL)),
                ('subteam', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='追加クラス', to='flexblock.group')),
            ],
            options={
                'verbose_name_plural': 'Network',
            },
        ),
    ]