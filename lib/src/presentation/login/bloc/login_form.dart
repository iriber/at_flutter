
import 'package:agro_tracking_flutter/src/utils/forms/form_bool_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_string_item.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class LoginForm{

  FormStringItem _email = FormStringItem();
  FormStringItem _password = FormStringItem();
  FormBoolItem _rememberMe = FormBoolItem();

  LoginForm(this._email, this._password, this._rememberMe);

  String? _errorLogin;

  FormStringItem getEmail() => _email;
  FormStringItem getPassword() => _password;
  FormBoolItem getRememberMe() => _rememberMe;
  String? getErrorLogin() => _errorLogin;

  bool validate(){
    bool isValid=true;
    isValid = isValid && !this._email.checkEmpty(msg:Fionai18n.message("email.required"));
    isValid = isValid && !this._password.checkEmpty(msg:Fionai18n.message("password.required"));
    _errorLogin = Fionai18n.message("fields.required");
    return isValid;
  }

  LoginForm.empty() {
    _email = FormStringItem();
    _password = FormStringItem();
    _rememberMe = FormBoolItem();
  }

}
