from django.urls import path, include
from . import views
from django.conf import settings
from django.conf.urls.static import static
urlpatterns = [
    path("", views.index, name="index"),
    path("profile", views.page, name="page"),
    # path("profile", views.profiles, name="profiles")
]
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)