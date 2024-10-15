import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/domain/lot.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/domain/track_food.dart';
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
    on<TrackSetPaddockRequested>(_onTrackSetPaddockRequested);
    on<TrackSetTrackTypeRequested>(_onTrackSetTrackTypeRequested);

    on<TrackLivestockEditTrackAnimalRequested>(_onTrackLivestockEditTrackAnimalRequested);
    on<TrackLivestockEditTrackFoodRequested>(_onTrackLivestockEditTrackFoodRequested);

    on<TrackAddRequested>(_onTrackAddRequested);

  }

  Future<void> _onInitTrackAddRequested(
      InitTrackAddRequested event, Emitter<TrackAddState> emit) async {

    Farm farm = await SharedPrefUtils().getSelectedFarm();

    TrackForm form = event.getForm()??TrackForm.empty();
    form.trackType = TrackType.empty;
    form.trackLivestockType = TrackLivestockType.empty;

    if( form.originalTrack != null){

      emit(state.copyWithoutMessage(
          status: () => TrackAddStatus.selectPadock,
          form: () => form
      ));
    }else{
      emit(state.copyWithoutMessage(
          status: () => TrackAddStatus.initial,
          farm: () => farm,
          form: () => form
      ));
    }


  }

  Future<void> _onTrackSetDateRequested(
      TrackSetDateRequested event, Emitter<TrackAddState> emit) async {

    TrackForm form = event.getForm();
    form.trackType = TrackType.empty;
    form.trackLivestockType = TrackLivestockType.empty;

    Track track = form.buildTrack();
    Farm farm = await SharedPrefUtils().getSelectedFarm();
    User user = await SharedPrefUtils().getUser();
    track.farmId = farm.id;
    track.userId = user.id;

    await _service.saveTrack(track).then((result) async {

        form.fill(result);

        emit(state.copyWithoutMessage(
          status: () => TrackAddStatus.selectPadock,
          form: () => form
      )
      );


    }).catchError((exception, stackTrace) {

      emit(state.copyWith(
          status: () => TrackAddStatus.failure,
          message: () => exception.toString()
      ));

    });


  }

  Future<void> _onTrackSetPaddockRequested(
      TrackSetPaddockRequested event, Emitter<TrackAddState> emit) async {


    //TODO validate;

    TrackForm form = event.getForm();

    /*
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
*/

    //por cada lote del paddock armo un track food.
    //TODO ver que pasa si no tiene lotes, si es un corral.
    Paddock paddock = form.getPaddock().getValue()??Paddock.empty();
    List<Lot> lots = paddock.lots??List.empty();

    lots.forEach( (item) {
      form.addTrackFood(TrackFood(lotId: item.id, lotDesc: item.name, paddockId: paddock.id));
    });



    /*
    form.editTrackFood(TrackFood(lotId: 1, lotDesc: "Lote 001", hectares: 50));
    form.editTrackFood(TrackFood(lotId: 2, lotDesc: "Lote 002", hectares: 0));
    form.editTrackFood(TrackFood(lotId: 3, lotDesc: "Lote 003", hectares: 0));
    form.editTrackFood(TrackFood(lotId: 4, lotDesc: "Lote 004", hectares: 0));
   */



    emit(
        state.copyWithoutMessage(
            status: () => TrackAddStatus.selectLivestockType,
            form: () => form
        )
    );

  }

  Future<void> _onTrackSetTrackTypeRequested(
      TrackSetTrackTypeRequested event, Emitter<TrackAddState> emit) async {


    TrackForm form = event.getForm();
    form.trackType = TrackType.livestock;
    form.trackLivestockType = TrackLivestockType.empty;;


    emit(
        state.copyWithoutMessage(
            status: () => TrackAddStatus.selectLivestockType,
            form: () => form
        )
    );

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


  Future<void> _onTrackLivestockEditTrackAnimalRequested(
      TrackLivestockEditTrackAnimalRequested event, Emitter<TrackAddState> emit) async {

    //TODO validate;

    TrackForm form = state.form??TrackForm.empty();

    Paddock paddock = form.getPaddock().getValue()??Paddock.empty();
    TrackAnimal trackAnimal = event.getTrackAnimal();
    trackAnimal.paddockId = paddock.id;
    form.editTrackAnimal(trackAnimal);

    Track track = form.buildTrack();
    Farm farm = await SharedPrefUtils().getSelectedFarm();
    User user = await SharedPrefUtils().getUser();
    track.farmId = farm.id;
    track.userId = user.id;

    await _service.saveTrack(track).then((result) async {

      emit(state.copyWithoutMessage(
          //status: () => TrackAddStatus.editAnimalTracks,
          form: () => form
      )
      );


    }).catchError((exception, stackTrace) {

      emit(state.copyWith(
          status: () => TrackAddStatus.failure,
          message: () => exception.toString()
      ));

    });
    /*
    emit(
        state.copyWithoutMessage(
          //status: () => TrackAddStatus.editAnimalTracks,
            form: () => form
        )
    );
*/
  }

  Future<void> _onTrackLivestockEditTrackFoodRequested(
      TrackLivestockEditTrackFoodRequested event, Emitter<TrackAddState> emit) async {

    //TODO validate;
    TrackForm form = state.form??TrackForm.empty();
    form.editTrackFood(event.getTrackFood());

    emit(
        state.copyWithoutMessage(
            //status: () => TrackAddStatus.editAnimalTracks,
            form: () => form
        )
    );

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
