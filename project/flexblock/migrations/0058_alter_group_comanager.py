# Generated by Django 5.1 on 2024-09-30 22:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_customuser_is_admin_alter_customuser_email_and_more'),
        ('flexblock', '0057_alter_group_comanager'),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='comanager',
            field=models.ManyToManyField(blank=True, related_name='comanager_groups', to='accounts.account'),
        ),
    ]