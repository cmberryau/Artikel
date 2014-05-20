import os

BASE_DIR = os.path.dirname(os.path.dirname(__file__))

from wsgi import SITE_TITLE, SITE_URL, LOCAL_FILE_SYSTEM_PREFIX
from secretkey import SECRET_KEY

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False
TEMPLATE_DEBUG = False

# Needs to be edited before use!
EMAIL_HOST = 'mail.somehost.com'
EMAIL_HOST_PASSWORD = 'areallygoodpassword'
EMAIL_HOST_USER = 'someone@somehost.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
SERVER_EMAIL = EMAIL_HOST_USER

ADMINS = (
    ('John Smith', 'johnsmith@somehost.com'),
)

ALLOWED_HOSTS = "*"
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'widget_tweaks',
    'accounts',
    'articles',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = SITE_TITLE + '.urls'

WSGI_APPLICATION = 'wsgi.application'

# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

# Needs to be edited before use!
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'thesqltablename',
        'USER': 'thesqluser',
        'PASSWORD': 'anothereallygoodpassword',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'public/static/')

TEMPLATE_DIRS = os.path.join(BASE_DIR, 'templates')

# Custom auth model
AUTH_USER_MODEL = 'accounts.EmailUser'
LOGIN_REDIRECT_URL = '/account/manage'
LOGIN_URL = '/account/signin'
LOGOUT_URL = '/account/signout'

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'mail_admins': {
            'level': 'INFO',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
        },
        '__mailadmin__': {
            'handlers': ['mail_admins'],
            'level': 'INFO',
            'propogate': True,
        },
    }
}