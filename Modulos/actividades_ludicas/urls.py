from django.urls import path
from . import views

urlpatterns = [
    path('', views.juegos, name='juegos'),
    #path('juegos/jugadores/', views.juegadores, name='jugdores'),
]