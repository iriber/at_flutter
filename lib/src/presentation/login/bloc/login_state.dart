import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus { accountLocked, connectivityFailure, companyAlreadySelected, alreadyLogged, initial, sending, loading, success, failure }

class LoginState extends Equatable {

  final LoginStatus status;
  LoginForm? form;
  String? message;
  User? user;
  Farm? company;

  LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.company,
    this.form,
    this.message=""
  });


  LoginState copyWith({
    LoginStatus Function()? status,
    LoginForm Function()? form,
    User Function()? user,
    Farm Function()? company,
    String Function()? message,
  }) {
    return LoginState(
      status: status != null ? status() : this.status,
      form: form != null ? form() : this.form,
      user: user != null ? user() : this.user,
      company: company != null ? company() : this.company,
      message: message != null ? message() : this.message,
    );
  }
  LoginState copyWithoutErrors({
    LoginStatus Function()? status,
    bool Function()? hideContainer,
    LoginForm Function()? form,
    User Function()? user,
    Farm Function()? company,
  }) {
    return LoginState(
      status: status != null ? status() : this.status,
      form: form != null ? form() : this.form,
      user: user != null ? user() : this.user,
      company: company != null ? company() : this.company,
    );
  }

  @override
  List<Object?> get props => [
    status,
    form,
    user,
    company
  ];
}