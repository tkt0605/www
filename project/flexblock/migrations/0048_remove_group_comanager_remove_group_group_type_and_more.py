# Generated by Django 5.1 on 2024-09-28 22:52

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0047_alter_group_web_site'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
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
        migrations.CreateModel(
            name='CoGroup',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=30, null=True, verbose_name='Class名')),
                ('category', models.CharField(max_length=15, null=True, verbose_name='カテゴリ')),
                ('visibility', models.CharField(choices=[('public', 'Public'), ('local', 'Local')], default='public', max_length=10, verbose_name='可視性')),
                ('web_site', models.TextField(blank=True, help_text='複数のURLを@で区切って入力してください')),
                ('backimage', models.ImageField(upload_to='backimage/', verbose_name='BackImage')),
                ('index', models.CharField(max_length=100, null=True, verbose_name='見出し')),
                ('created_at', models.DateField(auto_now_add=True, null=True, verbose_name='作成日')),
                ('comanager', models.ManyToManyField(blank=True, related_name='comanager_groups', to='flexblock.rootauth')),
                ('mainuser', models.ManyToManyField(blank=True, related_name='メインユーザー', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name_plural': 'CoGroup',
            },
        ),
    ]
