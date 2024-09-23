import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/nav_app_title.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agro_tracking_flutter/src/data/exceptions/connectivity_exception.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';


class TrackAddBloc extends Bloc<TrackAddEvent, TrackAddState> {

  final FacadeService _service = FacadeService() ;
  FionaLogger logger = DependencyManager().get<FionaLogger>();

  TrackAddBloc() :
        super(TrackAddState()) {
    on<InitTrackAddRequested>(_onInitTrackAddRequested);
    on<TrackSetDateRequested>(_onTrackSetDateRequested);
    on<TrackSetTrackTypeRequested>(_onTrackSetTrackTypeRequested);
    on<TrackSetLivestockTypeRequested>(_onTrackSetLivestockTypeRequested);

    on<TrackAddRequested>(_onTrackAddRequested);

  }

  Future<void> _onInitTrackAddRequested(
      InitTrackAddRequested event, Emitter<TrackAddState> emit) async {

    Farm farm = await SharedPrefUtils().getSelectedFarm();
    
    emit(state.copyWithoutMessage(
        status: () => TrackAddStatus.initial,
        farm: () => farm,
        form: () => event.getForm()??TrackForm.empty()
    ));

  }

  Future<void> _onTrackSetDateRequested(
      TrackSetDateRequested event, Emitter<TrackAddState> emit) async {

    //TODO validate;

    emit(state.copyWithoutMessage(status: () => TrackAddStatus.selectTrackType));


  }

  Future<void> _onTrackSetTrackTypeRequested(
      TrackSetTrackTypeRequested event, Emitter<TrackAddState> emit) async {

    //TODO validate;

    emit(state.copyWithoutMessage(status: () => TrackAddStatus.selectLivestockType));

  }

  Future<void> _onTrackSetLivestockTypeRequested(
      TrackSetLivestockTypeRequested event, Emitter<TrackAddState> emit) async {

    //TODO validate;

    emit(state.copyWithoutMessage(status: () => TrackAddStatus.editAnimalTracks));


  }

  Future<void> _onTrackAddRequested(
      TrackAddRequested event, Emitter<TrackAddState> emit) async {

   emit(state.copyWithoutMessage(status: () => TrackAddStatus.sending));

   //TODO validate;
   User user = await SharedPrefUtils().getUser();
   Farm farm = await SharedPrefUtils().getSelectedFarm();
   
   Track track = event.getForm().buildTrack();
   track.userId = user.id;
   track.farmId = farm.id;
   
    
   await _service.addTrack(track).then((result) async {

     emit(state.copyWithoutMessage(
         status: () => TrackAddStatus.success
     ));


   }).catchError((exception, stackTrace) {

     emit(state.copyWith(
         status: () => TrackAddStatus.failure,
         message: () => exception.toString()
     ));

   });

  }


  bool _checkFields(TrackAddRequested event) {

    bool hasError=!event.getForm().validate();
    if (hasError) {
      emit(
        state.copyWith(
            status: () => TrackAddStatus.failure,
            form: () => event.getForm()),
      );
    }

    return hasError;
  }



}
