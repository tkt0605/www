# Generated by Django 5.1 on 2024-10-03 03:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0004_remove_customuser_is_admin_alter_customuser_email_and_more'),
        ('flexblock', '0060_alter_group_comanager'),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='comanager',
            field=models.ManyToManyField(blank=True, related_name='rootauths', to='accounts.account'),
        ),
    ]
