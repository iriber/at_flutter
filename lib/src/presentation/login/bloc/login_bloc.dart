import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agro_tracking_flutter/src/data/exceptions/connectivity_exception.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final FacadeService _service = FacadeService() ;
  FionaLogger logger = DependencyManager().get<FionaLogger>();

  LoginBloc() :
        super(LoginState()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckUserLoggedRequested>(_onCheckUserLoggedRequested);
    on<SuccessHomeRequested>(_onSuccessHomeRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {

    await SharedPrefUtils().userLogout();

    emit(state.copyWithoutErrors(status: () => LoginStatus.sending));

    bool hasError = _checkFields(event);

    if (!hasError) {

      String email = event.getForm().getEmail().value??"";
      String password = event.getForm().getPassword().value??"";

      await _service
          .login( email, password )
          .then((user) async {
        await SharedPrefUtils().saveUser(user);

        if (event.getForm().getRememberMe().isChecked()) {
          await SharedPrefUtils().saveRememberedUser(user);
        }

        emit(state.copyWithoutErrors(
          status: () => LoginStatus.success,
          user: () => user,
        ));
      }).catchError((exception, stackTrace) {
        logger.e("FunPass Login ERROR: ${exception.toString()}");

        LoginStatus statusFailure = (exception is ConnectivityException)?LoginStatus.connectivityFailure:LoginStatus.failure;

        emit(state.copyWith(
            status: () => statusFailure,
            form: () => event.getForm()));

      });
    }
  }

  Future<void> _onSuccessHomeRequested(
      SuccessHomeRequested event, Emitter<LoginState> emit) async {
    //use dto to fill form on errors.
    var user = await SharedPrefUtils().getUser();
    var message = event.getMessage();
    emit(state.copyWithoutErrors(
        status: () => LoginStatus.success,
        user: () => user,
    ));
  }

  bool _checkFields(LoginRequested event) {

    bool hasError=!event.getForm().validate();
    if (hasError) {
      emit(
        state.copyWith(
            status: () => LoginStatus.failure,
            form: () => event.getForm()),
      );
    }

    return hasError;
  }


  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<LoginState> emit) async {

    await SharedPrefUtils().userLogout();
    await SharedPrefUtils().removeSelectedFarm();


    emit(state.copyWithoutErrors(
      status: () => LoginStatus.initial,
      hideContainer: () =>  false,
      user: () => User.empty(),
      company: () => Farm.empty(),
      form: () => LoginForm.empty()
    ));
  }

  Future<void> _onCheckUserLoggedRequested(
      CheckUserLoggedRequested event, Emitter<LoginState> emit) async {
    if (await SharedPrefUtils().userIsLogged()) {

      User user = await SharedPrefUtils().getUser();

      if (await SharedPrefUtils().isFarmSelected()){

        Farm company = await SharedPrefUtils().getSelectedFarm();

        emit(state.copyWithoutErrors(
          status: () => LoginStatus.companyAlreadySelected,
          user: () => user,
          company: () => company
        ));
      }else{
        emit(state.copyWithoutErrors(
          status: () => LoginStatus.alreadyLogged,
          user: () => user,
        ));
      }

    } else {
      await SharedPrefUtils().removeSelectedFarm();
      emit(state.copyWithoutErrors(
        status: () => LoginStatus.initial,
        user: () => User.empty(),
        form: () => LoginForm.empty()
      ));
    }
  }
}
