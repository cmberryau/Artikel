from django.conf.urls import patterns, include, url
from django.contrib import admin, auth

admin.autodiscover()

urlpatterns = patterns('',
    # accounts app
    url(r'^', include('accounts.urls', namespace='accounts')),
    url(r'^account/', include('accounts.urls', namespace='accounts')),
    # articles app
    url(r'^articles/', include('articles.urls', namespace='articles')),
    # django in-built admin app
    url(r'^admin/', include(admin.site.urls)),
)
