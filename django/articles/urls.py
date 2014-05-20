from django.conf.urls import patterns, include, url

from articles import views
from articles.views import Articles

urlpatterns = patterns('',
    url(r'^$', Articles.as_view(), name='articles'),
)