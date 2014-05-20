from django.contrib.sites.models import get_current_site
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from django.views.generic.base import View

from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_protect
from django.utils.decorators import method_decorator

import json
import re

from articles.models import Word

word_pattern = r'^([dD](er|ie|as)) (?u)[^\W\d_]+$'
word_regex = re.compile(word_pattern)

class Articles(View):
    """
    A view that lets people test articles, must be logged in
    """
    # setup all the decorators for this class
    @method_decorator(login_required)
    @method_decorator(csrf_protect)
    def dispatch(self, *args, **kwargs):
        return super(Articles, self).dispatch(*args, **kwargs)

    def get(self, request, template_name='articles/articles.html',
            current_app=None, extra_context=None):
        
        word = get_next_word(None)

        # if there is no words registered, show entry div
        if word is None:
            testing_class = 'hidden'
            entering_class = 'nothidden'
        else:
            testing_class = 'nothidden'
            entering_class = 'hidden'

        current_site = get_current_site(request)
        context = {
            'word' : word,
            'site': current_site,
            'site_name': current_site.name,
            'testing_class' : testing_class,
            'entering_class' : entering_class,            
        }

        if extra_context is not None:
            context.update(extra_context)        

        return render(request, template_name, context,
                      current_app=current_app)

    def post(self, request):
        if request.is_ajax():
            characters = request.POST.get('word')
            article = request.POST.get('article')

            # receiving a article & characters query
            if characters is not None and article is not None:
                word = Word.objects.get(characters=characters)
                
                if word is not None:
                    if word.article == article:
                        next_word = get_next_word(word)

                        json_response = {
                            'result' : 'true',
                            'next_word' : next_word.characters
                        }

                    else:
                        json_response = {
                            'result' : 'false',
                            'next_word' : word.characters
                        }

                    return HttpResponse(json.dumps(json_response), 
                           content_type='application/json')

            next_word_characters = request.POST.get('new_word')

            # receiving a new word
            if next_word_characters is not None:
                # save the new word if the regex matches
                if word_regex.match(next_word_characters.strip()):
                    if len(next_word_characters.split()) is 2:
                        article = next_word_characters.split()[0]
                        characters = next_word_characters.split()[1]

                        try:
                            Word.objects.get(characters=characters.title())
                        except ObjectDoesNotExist:
                            word = Word(article=article.lower(), characters=characters.title())
                            word.save()

                            json_response = {'result' : 'added',}
                        else:
                            json_response = {'result' : 'already_exists',}

                    return HttpResponse(json.dumps(json_response), 
                           content_type='application/json')
                    
        # nothing has gone well here            
        return HttpResponse(json.dumps({'result' : 'error'}),
               content_type='application/json')

def get_next_word(word):
    """
    Returns the next word
    """
    if word is not None:
        try:
            return Word.objects.get(pk=word.pk+1)
        except ObjectDoesNotExist:
            pass

    try:
        return Word.objects.get(pk=1)
    except ObjectDoesNotExist:
        next_word = None

    return next_word