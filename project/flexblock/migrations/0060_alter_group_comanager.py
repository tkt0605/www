# Generated by Django 5.1 on 2024-10-03 03:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0059_alter_group_comanager'),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='comanager',
            field=models.ManyToManyField(blank=True, related_name='rootauths', to='flexblock.rootauth'),
        ),
    ]
