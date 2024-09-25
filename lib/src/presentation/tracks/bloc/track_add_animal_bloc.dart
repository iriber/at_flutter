import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/nav_app_title.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_animal_form.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agro_tracking_flutter/src/data/exceptions/connectivity_exception.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';


class TrackAddAnimalBloc extends Bloc<TrackAddAnimalEvents, TrackAddAnimalState> {

  final FacadeService _service = FacadeService() ;
  FionaLogger logger = DependencyManager().get<FionaLogger>();

  TrackAddAnimalBloc() :
        super(TrackAddAnimalState()) {
    on<InitTrackAnimalAddRequested>(_onInitTrackAnimalAddRequested);
    on<TrackAddAnimalRequested>(_onTrackAddAnimalRequested);

  }

  Future<void> _onInitTrackAnimalAddRequested(
      InitTrackAnimalAddRequested event, Emitter<TrackAddAnimalState> emit) async {

    //Farm farm = await SharedPrefUtils().getSelectedFarm();

    TrackAnimalForm form = event.getForm()??TrackAnimalForm.empty();

    emit(state.copyWithoutMessage(
        status: () => TrackAddAnimalStatus.initial,
        form: () => form
    ));

  }

  Future<void> _onTrackAddAnimalRequested(
      TrackAddAnimalRequested event, Emitter<TrackAddAnimalState> emit) async {

     emit(state.copyWithoutMessage(status: () => TrackAddAnimalStatus.sending));

     if(_checkFields(event)){
       emit(state.copyWithoutMessage(
           status: () => TrackAddAnimalStatus.success,
           form: () => event.form

       ));
     }

  }


  bool _checkFields(TrackAddAnimalRequested event) {

    bool hasError=!event.getForm().validate();
    if (hasError) {
      emit(
        state.copyWith(
            status: () => TrackAddAnimalStatus.failure,
            message: ()  => event.getForm().getError()??"",
            form: () => event.getForm()),
      );
    }

    return !hasError;
  }



}
