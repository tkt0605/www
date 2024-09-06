# Generated by Django 5.1 on 2024-09-06 12:06

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0001_initial'),
        ('flexblock', '0012_alter_group_options'),
    ]

    operations = [
        migrations.CreateModel(
            name='GroupMembership',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('join_date', models.DateTimeField(auto_now_add=True, null=True, verbose_name='参加日')),
                ('account', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='accounts.account', verbose_name='ユーザー名')),
                ('group', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='flexblock.group', verbose_name='参加グループ名')),
            ],
            options={
                'unique_together': {('account', 'group')},
            },
        ),
    ]