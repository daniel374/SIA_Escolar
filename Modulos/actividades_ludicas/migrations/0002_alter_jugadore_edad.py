# Generated by Django 3.2 on 2021-12-17 16:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('actividades_ludicas', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='jugadore',
            name='edad',
            field=models.IntegerField(max_length=2),
        ),
    ]