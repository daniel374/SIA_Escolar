# Generated by Django 3.2 on 2021-12-17 16:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('actividades_ludicas', '0002_alter_jugadore_edad'),
    ]

    operations = [
        migrations.AlterField(
            model_name='jugadore',
            name='edad',
            field=models.IntegerField(verbose_name=range(1, 100)),
        ),
    ]
