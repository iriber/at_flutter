
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';

abstract class LoginEvent {
  const LoginEvent();

}

class LoginRequested extends LoginEvent {
  final LoginForm _form;

  const LoginRequested(this._form);

 LoginForm getForm() => _form;

}

class LogoutRequested extends LoginEvent {

  const LogoutRequested();

}

class CheckUserLoggedRequested extends LoginEvent {

  const CheckUserLoggedRequested();

}

class SuccessHomeRequested extends LoginEvent {
  final String _message;
  const SuccessHomeRequested(this._message);

  String getMessage() => _message;

}