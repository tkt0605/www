# Generated by Django 5.1 on 2024-09-28 04:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flexblock', '0046_addnetwork_is_denied'),
    ]

    operations = [
        migrations.AlterField(
            model_name='group',
            name='web_site',
            field=models.TextField(blank=True, help_text='複数のURLを@で区切って入力してください'),
        ),
    ]