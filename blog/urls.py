from django.urls import path
from . import views
app_name = 'blog'
urlpatterns = [
    # представления поста
    path('', views.home, name='home'),

]