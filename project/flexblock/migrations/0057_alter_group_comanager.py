# Generated by Django 5.1 on 2024-09-30 12:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0056_delete_category'),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='comanager',
            field=models.ManyToManyField(blank=True, related_name='comanager_groups', to='flexblock.rootauth'),
        ),
    ]
