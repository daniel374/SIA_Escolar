from django.db import models


# Create your models here.
class Juego(models.Model):
    id_juego = models.AutoField(primary_key=True)
    nombre_juego = models.CharField(max_length=50)
    tipos_juegos = [
        ('G', 'Grupal'),
        ('I', 'Individual'),
        ('R', 'ROL')
    ]
    tipo = models.CharField(max_length=1, choices=tipos_juegos, default='G')
    
    def __str__(self):
        txt = '{0} / {1}'
        return txt.format(self.nombre_juego, self.tipo)


class Jugadore(models.Model):
    id_jugador = models.AutoField(primary_key=True)
    nombre_jugador = models.CharField(max_length=30)
    correo = models.CharField(max_length=30)
    edad = models.IntegerField(range(1, 100))
    juegos = models.ManyToManyField(Juego)
    
    def __str__(self):
        txt = '{0}'
        return txt.format(self.nombre_jugador)