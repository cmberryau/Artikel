from django.db import models

class Word(models.Model):
    characters = models.CharField('Characters', max_length=256)
    article = models.CharField('Article', max_length=3)