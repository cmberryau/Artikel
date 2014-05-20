from django import forms
from django.contrib.auth.forms import AuthenticationForm, ReadOnlyPasswordHashField
from django.contrib.auth import authenticate, get_user_model
from django.utils.translation import ugettext, ugettext_lazy as _

from accounts.models import EmailUser

def is_password_strong(password):
    minimum_password_length = 10

    if len(password) < minimum_password_length:
        return False

    return True

class EmailUserCreationForm(forms.ModelForm):
    """
    A form that creates a user, with no privileges, from the given email and
    password.
    """

    error_messages = {
        'duplicate_email': _("That email is already in use."),
        'password_mismatch': _("The two password fields didn't match."),
        'password_weak': _("Come on, use at least 10 letters..."),
    }
    email = forms.EmailField(label=_('Email address'))
    password1 = forms.CharField(label=_("Password"),
        widget=forms.PasswordInput)
    password2 = forms.CharField(label=_("Password confirmation"),
        widget=forms.PasswordInput,
        help_text=_("Enter the same password as above, for verification."))

    class Meta:
        model = EmailUser
        fields = ("email",)

    def clean_email(self):
        # Since User.email is unique, this check is redundant,
        # but it sets a nicer error message than the ORM. See #13147.
        email = self.cleaned_data["email"]
        try:
            EmailUser._default_manager.get(email=email)
        except EmailUser.DoesNotExist:
            return email
        raise forms.ValidationError(
            self.error_messages['duplicate_email'],
            code='duplicate_email',
        )

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError(
                self.error_messages['password_mismatch'],
                code='password_mismatch',
            )

        if not is_password_strong(password2):
            raise forms.ValidationError(
                self.error_messages['password_weak'],
                code='password_weak',
            )

        return password2

    def save(self, commit=True):
        user = super(EmailUserCreationForm, self).save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user

class EmailUserManageForm(forms.ModelForm):
    """
    A form that allows us to change the first and last name of an EmailUser
    and to change the password.
    """

    error_messages = {
        'duplicate_email': _("That email is already in use."),
        'password_mismatch': _("The two password fields didn't match."),
        'password_weak': _("Come on, use at least 10 letters..."),
    }

    first_name = forms.CharField(label=_("First Name"), required=False)
    last_name = forms.CharField(label=_("Last Name"), required=False)
    new_password1 = forms.CharField(label=_("Password"),
        widget=forms.PasswordInput, 
        required=False)
    new_password2 = forms.CharField(label=_("Password confirmation"),
        widget=forms.PasswordInput,
        help_text=_("Enter the same password as above, for verification."),
        required=False)

    class Meta:
        model = EmailUser
        fields = ('first_name', 'last_name')

    def __init__(self, user, *args, **kwargs):
        super(EmailUserManageForm, self).__init__(*args, **kwargs)
        self.user = user

    def clean_first_name(self):
        first_name = self.cleaned_data.get("first_name")

        if len(first_name) == 0:
            return None

        return first_name

    def clean_last_name(self):
        last_name = self.cleaned_data.get("last_name")

        if len(last_name) == 0:
            return None

        return last_name

    def clean_new_password2(self):
        new_password1 = self.cleaned_data.get("new_password1")
        new_password2 = self.cleaned_data.get("new_password2")

        if new_password1 and new_password2 and new_password1 != new_password2:
            raise forms.ValidationError(
                self.error_messages['password_mismatch'],
                code='password_mismatch',
            )

        if len(new_password1) == 0 or len(new_password2) == 0:
            return None;

        if not is_password_strong(new_password2):
            raise forms.ValidationError(
                self.error_messages['password_weak'],
                code='password_weak',
            )

        return new_password2

    def save(self, commit=True):
        if self.cleaned_data['new_password2'] is not None:
            self.user.set_password(self.cleaned_data['new_password2'])

        if self.cleaned_data['first_name'] is not None:
            self.user.first_name = self.cleaned_data['first_name']

        if self.cleaned_data['last_name'] is not None:
            self.user.last_name = self.cleaned_data['last_name']

        if commit:
            self.user.save()

        return self.user

class EmailUserChangeForm(forms.ModelForm):
    email = forms.EmailField(label=_('Email address'))
    password = ReadOnlyPasswordHashField(label=_("Password"),
        help_text=_("Raw passwords are not stored, so there is no way to see "
                    "this user's password, but you can change the password "
                    "using <a href=\"password/\">this form</a>."))

    class Meta:
        model = EmailUser
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(EmailUserChangeForm, self).__init__(*args, **kwargs)
        f = self.fields.get('user_permissions', None)
        if f is not None:
            f.queryset = f.queryset.select_related('content_type')

    def clean_password(self):
        # Regardless of what the user provides, return the initial value.
        # This is done here, rather than on the field, because the
        # field does not have access to the initial value
        return self.initial["password"]

class EmailUserAuthenticationForm(forms.Form):
    """
    Base class for authenticating users. Extend this to get a form that accepts
    username/password logins.
    """
    email = forms.EmailField(label=_('Email address'))
    password = forms.CharField(label=_("Password"), widget=forms.PasswordInput)

    error_messages = {
        'invalid_login': _("Invalid email and/or password."),
        'inactive': _("This account is inactive."),
    }

    def __init__(self, request=None, *args, **kwargs):
        """
        The 'request' parameter is set for custom auth use by subclasses.
        The form data comes in via the standard 'data' kwarg.
        """
        self.request = request
        self.user_cache = None
        super(EmailUserAuthenticationForm, self).__init__(*args, **kwargs)

        # Set the label for the "email" field.
        UserModel = get_user_model()
        self.username_field = UserModel._meta.get_field(UserModel.USERNAME_FIELD)
        if self.fields['email'].label is None:
            self.fields['email'].label = capfirst(self.username_field.verbose_name)

    def clean(self):
        email = self.cleaned_data.get('email')
        password = self.cleaned_data.get('password')

        if email and password:
            self.user_cache = authenticate(username=email,
                                           password=password)
            if self.user_cache is None:
                raise forms.ValidationError(
                    self.error_messages['invalid_login'],
                    code='invalid_login',
                )
            elif not self.user_cache.is_active:
                raise forms.ValidationError(
                    self.error_messages['inactive'],
                    code='inactive',
                )
        return self.cleaned_data

    def check_for_test_cookie(self):
        warnings.warn("check_for_test_cookie is deprecated; ensure your login "
                "view is CSRF-protected.", DeprecationWarning)

    def get_user_id(self):
        if self.user_cache:
            return self.user_cache.id
        return None

    def get_user(self):
        return self.user_cache