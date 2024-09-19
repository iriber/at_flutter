import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_events.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_events.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_state.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppTitleBloc extends Bloc<AppTitleEvent, AppTitleState> {


  AppTitleBloc() :
        super(AppTitleState()) {

    on<DefaultTitleRequested>(_onDefaultTitleRequested);
    on<TitleChangeRequested>(_onTitleChangeRequested);
  }

  Future<void> _onDefaultTitleRequested(
      DefaultTitleRequested event,
      Emitter<AppTitleState> emit,
      ) async {

    emit(state.copyWith(
        status: () => AppTitleStatus.defaultTitle
    ));
  }

  Future<void> _onTitleChangeRequested(
      TitleChangeRequested event,
      Emitter<AppTitleState> emit,
      ) async {

      emit(state.copyWith(
          status: () => AppTitleStatus.titleChanged,
          title: () => event.title
      ));

  }
}