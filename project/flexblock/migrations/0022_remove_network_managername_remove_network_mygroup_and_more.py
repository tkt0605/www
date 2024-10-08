# Generated by Django 5.1 on 2024-09-07 12:38

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0021_alter_network_options_remove_network_explain'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='network',
            name='managername',
        ),
        migrations.RemoveField(
            model_name='network',
            name='mygroup',
        ),
        migrations.RemoveField(
            model_name='network',
            name='target_group',
        ),
        migrations.AlterField(
            model_name='network',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, null=True, verbose_name='作成日'),
        ),
        migrations.CreateModel(
            name='AddNetwork',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True, null=True, verbose_name='作成日')),
                ('group', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='flexblock.group')),
                ('name', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='flexblock.network')),
            ],
            options={
                'verbose_name_plural': 'AddNetwork',
            },
        ),
    ]
