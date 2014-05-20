from django.conf import settings
from django.shortcuts import resolve_url
from django.contrib.auth import REDIRECT_FIELD_NAME, authenticate, login as auth_login, logout as auth_logout
from django.contrib.auth.decorators import login_required
from django.contrib.sites.models import get_current_site
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseServerError
from django.utils.http import is_safe_url
from django.utils.translation import ugettext as _
from django.utils.decorators import method_decorator
from django.template.response import TemplateResponse

from django.views.generic.base import View
from django.views.decorators.debug import sensitive_post_parameters
from django.views.decorators.cache import never_cache
from django.views.decorators.csrf import csrf_protect

from accounts.forms import EmailUserCreationForm, EmailUserAuthenticationForm, EmailUserManageForm

@sensitive_post_parameters()
@csrf_protect
@never_cache
def register(request, template_name='accounts/register.html',
             registration_form=EmailUserCreationForm,
             title='registration',
             current_app=None, extra_context=None):
    """
    A view that validates a request to register a user
    if the request is valid, the user is logged in
    """
    form = registration_form()

    if request.method == 'POST':
        form = registration_form(request.POST)

        if form.is_valid():
            # save the user
            user = form.save()

            return TemplateResponse(request, 'accounts/thankyou.html')

    current_site = get_current_site(request)

    context = {
        'form' : form,
        'title' : title,
        'site' : current_site,
        'site_name' : current_site.name
    }

    if extra_context is not None:
        context.update(extra_context)    

    return TemplateResponse(request, template_name, context,
                            current_app=current_app)

@sensitive_post_parameters()
@csrf_protect
@never_cache
def signin(request, template_name='accounts/signin.html',
           redirect_field_name=REDIRECT_FIELD_NAME,
           authentication_form=EmailUserAuthenticationForm,
           title='sign in',
           current_app=None, extra_context=None):
    """
    Displays the signin form and handles the signin action.
    """
    redirect_to = request.POST.get(redirect_field_name,
              request.GET.get(redirect_field_name, ''))

    print('redirect_to: ' + redirect_to)

    if request.method == 'POST':
        form = authentication_form(data=request.POST)
        if form.is_valid():

            # Ensure the user-originating redirection url is safe.
            if not is_safe_url(url=redirect_to, host=request.get_host()):
                redirect_to = resolve_url(settings.LOGIN_REDIRECT_URL)

            # Okay, security check complete. Log the user in.
            auth_login(request, form.get_user())

            return HttpResponseRedirect(redirect_to)        
    else:
        form = authentication_form(request)

    current_site = get_current_site(request)

    context = {
            'form': form,
            redirect_field_name: redirect_to,
            'title' : title,
            'site': current_site,
            'site_name': current_site.name,
    }

    if extra_context is not None:
        context.update(extra_context)

    return TemplateResponse(request, template_name, context,
                            current_app=current_app)

@sensitive_post_parameters()
@csrf_protect
@never_cache
def signout(request, next_page=None,
            template_name='accounts/signout.html',
            redirect_field_name=REDIRECT_FIELD_NAME,
            current_app=None, extra_context=None):
    """
    Signs the user out and displays 'You are logged out' message.
    """
    auth_logout(request)

    if redirect_field_name in request.REQUEST:
        next_page = request.REQUEST[redirect_field_name]
        # Security check -- don't allow redirection to a different host.
        if not is_safe_url(url=next_page, host=request.get_host()):
            next_page = request.path

    if next_page:
        # Redirect to this page until the session has been cleared.
        return HttpResponseRedirect(next_page)

    current_site = get_current_site(request)
    context = {
        'site': current_site,
        'site_name': current_site.name,
        'title': _('Signed out')
    }

    if extra_context is not None:
        context.update(extra_context)

    return TemplateResponse(request, template_name, context,
                            current_app=current_app)

class Forgot(View):
    """
    A view that allows users who have forgot their details
    to reset their passwords
    """
    def get(self, request):
        return HttpResponse('forgot password get')

    def post(self, request):
        return HttpResponse('forgot password post')

class Manage(View):
    """
    A view that allows users to view and change account details
    """
    # setup all the decorators for this class
    @method_decorator(login_required)
    @method_decorator(csrf_protect)
    @method_decorator(never_cache)
    def dispatch(self, *args, **kwargs):
        return super(Manage, self).dispatch(*args, **kwargs)

    def get(self, request, template_name='accounts/manage.html',
            management_form=EmailUserManageForm,
            current_app=None, extra_context=None):

        form = management_form(user=request.user)

        current_site = get_current_site(request)
        context = {
            'form' : form,
            'user' : request.user,
            'site': current_site,
            'site_name': current_site.name,
        }

        if extra_context is not None:
            context.update(extra_context)

        return TemplateResponse(request, template_name, context,
                                current_app=current_app)

    @method_decorator(sensitive_post_parameters())
    def post(self, request, template_name='accounts/manage.html',
             management_form=EmailUserManageForm,
             current_app=None, extra_context=None):

        form = management_form(user=request.user, data=request.POST)

        current_site = get_current_site(request)
        context = {
            'form' : form,
            'site': current_site,
            'site_name': current_site.name,
        }

        if extra_context is not None:
            context.update(extra_context)

        if form.is_valid():
            form.save()

        return TemplateResponse(request, template_name, context,
                                current_app=current_app)
