# Generated by Django 5.1 on 2024-10-14 02:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0071_alter_rootauth_target_user_alter_rootauth_user'),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='comanager',
            field=models.ManyToManyField(blank=True, related_name='rootauths', to='flexblock.rootauth'),
        ),
    ]