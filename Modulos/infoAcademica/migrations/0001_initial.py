# Generated by Django 3.2 on 2021-12-17 16:16

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Carrera',
            fields=[
                ('codigo', models.CharField(max_length=3, primary_key=True, serialize=False)),
                ('nombre', models.CharField(max_length=50)),
                ('duracion', models.PositiveSmallIntegerField(default=5)),
            ],
        ),
        migrations.CreateModel(
            name='Curso',
            fields=[
                ('codCurso', models.CharField(max_length=6, primary_key=True, serialize=False)),
                ('nombre', models.CharField(max_length=30)),
                ('creditos', models.PositiveSmallIntegerField()),
                ('docente', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Estudiante',
            fields=[
                ('dni', models.CharField(max_length=10, primary_key=True, serialize=False)),
                ('primer_apellido', models.CharField(max_length=35)),
                ('segundo_apellido', models.CharField(max_length=35)),
                ('nombre', models.CharField(max_length=35)),
                ('fecha_nacimiento', models.DateField()),
                ('sexo', models.CharField(choices=[('F', 'Femenino'), ('M', 'Masculino')], default='F', max_length=1)),
                ('vigencia', models.BooleanField(default=True)),
                ('carrera', models.ForeignKey(on_delete=django.db.models.deletion.RESTRICT, to='infoAcademica.carrera')),
            ],
        ),
        migrations.CreateModel(
            name='Matriula',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('fechaMatricula', models.DateTimeField(auto_now_add=True)),
                ('estudiante', models.ForeignKey(on_delete=django.db.models.deletion.RESTRICT, to='infoAcademica.estudiante')),
            ],
        ),
    ]
