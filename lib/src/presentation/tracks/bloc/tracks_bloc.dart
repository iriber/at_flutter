import 'dart:async';

import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_state.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState>{

  final FacadeService _service = DependencyManager().get<FacadeService>() ;

  TracksBloc() : super(TracksState()) {

    on<FetchAllTracksRequested>(_onFetchAllTracksRequested);

  }

  Future<void> _onFetchAllTracksRequested(
      FetchAllTracksRequested event,
      Emitter<TracksState> emit,
      ) async {

    emit(state.copyWith(status: () => TracksStatus.loading));

    User user = await SharedPrefUtils().getUser();
    Farm farm = await SharedPrefUtils().getSelectedFarm();

    await _service.getTracks(farm).then((tracks)async{
      emit(state.copyWithoutMessage(
        status: () => TracksStatus.success,
        tracks: () => tracks,
        farm: () => farm
      ));
    }).catchError( (exception, stackTrace){

      emit(state.copyWith(
          status: () => TracksStatus.failure,
          message: () => exception.toString()
      ));
    });

  }

}