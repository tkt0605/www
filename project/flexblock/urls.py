from django.urls import path, include
from . import views
from django.conf import settings
from django.conf.urls.static import static
urlpatterns = [
    path("", views.index, name="index"),
    path("profile/<int:pk>", views.page, name="page"),
    path("community/<str:name>", views.community, name="community"),
    path("class/create.html", views.form_create, name="form_create"),
    path("flex/networks", views.networks, name="networks"),
    path("flex/networks/<str:name>", views.network, name="network"),
    path("flex/create-network", views.form_net, name="form_net"),
    path('send_auth_request/<int:pk>', views.send_auth_request, name='send_auth_request'),
    path('approve_auth_request/<int:pk>', views.approve_auth_request, name='approve_auth_request'),
    path("not_approve_auth_request/<int:pk>", views.not_approve_auth_request, name="not_approve_auth_request"),
    path('error/404', views.error, name='error'),
    path("create/post/<str:name>", views.form_post, name='form_post'),
    path('community/<str:name>/join', views.join, name='join'),
    path('community/<str:name>/joinout', views.joinout, name="joinout"),
    path("community/<str:name>/add_network/<int:pk>", views.add_network, name="add_network"),
    path("flex/networks/public/", views.public, name="public"),
    path("flex/networks/local/", views.local, name="local"),
    path("create/network_post/<str:name>", views.form_network_post, name='form_network_post'),
]
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)