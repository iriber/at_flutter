import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_events.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_state.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MenuBloc extends Bloc<MenuEvent, MenuState> {

  final FacadeService _service = DependencyManager().get<FacadeService>() ;

  MenuBloc() :
        super(MenuState()) {
    on<FetchAllMenusRequested>(_onFetchAllMenusRequested);
  }


  Future<void> _onFetchAllMenusRequested(
      FetchAllMenusRequested event,
      Emitter<MenuState> emit,
      ) async {

    if(!await SharedPrefUtils().userIsLogged() ){
      emit(state.copyWith(status: () => MenuStatus.loginRequired));
      return;
    }

    User user = await SharedPrefUtils().getUser();

    emit(state.copyWith(status: () => MenuStatus.loading));

    await _service.getMainMenu().then((mainMenu)async{
      //emit success status with the coupons

      await _service.getSidebarMenu().then((sidebarMenu)async{
        //emit success status with the coupons
        emit(state.copyWithoutMessage(
          status: () => MenuStatus.success,
          sidebarMenu: () => sidebarMenu,
          mainMenu: () => mainMenu,
        ));
      }).catchError( (error, stackTrace){

        emit(state.copyWith(
            status: () => MenuStatus.failure,
            message: () => error.toString()
        ));
      });

    }).catchError( (error, stackTrace){

        emit(state.copyWith(
            status: () => MenuStatus.failure,
            message: () => error.toString()
        ));
    });



  }

}