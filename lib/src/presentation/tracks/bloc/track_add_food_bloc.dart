import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_food_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_food_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_food_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class TrackAddFoodBloc extends Bloc<TrackAddFoodEvents, TrackAddFoodState> {

  final FacadeService _service = FacadeService() ;
  FionaLogger logger = DependencyManager().get<FionaLogger>();

  TrackAddFoodBloc() :
        super(TrackAddFoodState()) {
    on<InitTrackFoodAddRequested>(_onInitTrackFoodAddRequested);
    on<TrackAddFoodRequested>(_onTrackAddFoodRequested);

  }

  Future<void> _onInitTrackFoodAddRequested(
      InitTrackFoodAddRequested event, Emitter<TrackAddFoodState> emit) async {

    //Farm farm = await SharedPrefUtils().getSelectedFarm();

    TrackFoodForm form = event.getForm()??TrackFoodForm.empty();

    emit(state.copyWithoutMessage(
        status: () => TrackAddFoodStatus.initial,
        form: () => form
    ));

  }

  Future<void> _onTrackAddFoodRequested(
      TrackAddFoodRequested event, Emitter<TrackAddFoodState> emit) async {

     emit(state.copyWithoutMessage(status: () => TrackAddFoodStatus.sending));

     if(_checkFields(event)){


       emit(state.copyWithoutMessage(
           status: () => TrackAddFoodStatus.success

       ));
     }

  }


  bool _checkFields(TrackAddFoodRequested event) {

    bool hasError=!event.getForm().validate();
    if (hasError) {
      emit(
        state.copyWith(
            status: () => TrackAddFoodStatus.failure,
            message: ()  => event.getForm().getError()??"",
            form: () => event.getForm()),
      );
    }

    return !hasError;
  }



}
