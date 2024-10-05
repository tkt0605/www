# Generated by Django 5.1 on 2024-09-29 01:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_customuser_is_admin_alter_customuser_email_and_more'),
        ('flexblock', '0050_delete_cogroup'),
    ]

    operations = [
        migrations.AddField(
            model_name='group',
            name='comanager',
            field=models.ManyToManyField(blank=True, related_name='comanager_groups', to='accounts.account'),
        ),
        migrations.AddField(
            model_name='group',
            name='type',
            field=models.CharField(choices=[('single', 'シングル'), ('multipe', 'マルチ')], default='single', max_length=10, verbose_name='タイプ'),
        ),
    ]