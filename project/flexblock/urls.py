from django.urls import path, include
from . import views
from django.conf import settings
from django.conf.urls.static import static
urlpatterns = [
    path("", views.index, name="index"),
    path("profile", views.page, name="page"),
    path("community/<str:name>", views.community, name="community"),
    path("class/create.html", views.form_create, name="form_create"),
    path("flex/networks", views.networks, name="networks"),
    path("flex/networks/<str:name>", views.network, name="network"),
    path("flex/create-network", views.form_net, name="form_net"),
]
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)