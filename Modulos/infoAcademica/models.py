from django.db import models

# Create your models here.
class Carrera(models.Model):
    codigo = models.CharField(max_length=3, primary_key=True)
    nombre = models.CharField(max_length=50)
    duracion = models.PositiveSmallIntegerField(default=5)

    def __str__(self):
        txt = "{0} (Duración: {1} año(s))"
        return txt.format(self.nombre, self.duracion)


class Estudiante(models.Model):
    dni = models.CharField(max_length=10, primary_key=True)
    primer_apellido = models.CharField(max_length=35)
    segundo_apellido = models.CharField(max_length=35)
    nombre = models.CharField(max_length=35)
    fecha_nacimiento = models.DateField()
    sexos = [
        ('F', 'Femenino'),
        ('M', 'Masculino')
    ]
    sexo = models.CharField(max_length=1, choices=sexos, default='F')
    carrera = models.ForeignKey(Carrera, null=False, blank=False, on_delete=models.RESTRICT)
    vigencia = models.BooleanField(default=True)

    def nombre_completo(self):
        txt_nombre = "{0} {1} {2}"
        return txt_nombre.format(self.primer_apellido, self.segundo_apellido, self.nombre)

    def __str__(self):
        txt = "{0} /carrera {1} / {2}"
        if self.vigencia:
            estado_estudiante = "VIGENTE"
        else:
            estado_estudiante = "INACTIVO"
        return txt.format(self.nombre_completo(),self.carrera, estado_estudiante)


class Curso(models.Model):
    codCurso = models.CharField(max_length=6, primary_key=True)
    nombre = models.CharField(max_length=30)
    creditos = models.PositiveSmallIntegerField()
    docente = models.CharField(max_length=100)


class Matriula(models.Model):
    id = models.AutoField(primary_key=True)
    estudiante = models.ForeignKey(Estudiante, null=False, blank=False, on_delete=models.RESTRICT)
    fechaMatricula = models.DateTimeField(auto_now_add=True)
