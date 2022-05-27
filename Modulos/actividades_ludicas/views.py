from django.shortcuts import render

# Create your views here.
def juegos(request):
    return render(request, 'juegos.html', {})