import 'dart:async';

import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_events.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_state.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_events.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class FarmSelectBloc extends Bloc<FarmSelectEvent, FarmSelectState>{

  final FacadeService _service = DependencyManager().get<FacadeService>() ;

  FarmSelectBloc() : super(FarmSelectState()) {

    on<FetchAllFarmsRequested>(_onFetchAllCompaniesRequested);
    on<SelectFarmRequested>(_onSelectCompanyRequested);
    on<UnselectFarmRequested>(_onUnselectCompanyRequested);

  }

  Future<void> _onFetchAllCompaniesRequested(
      FetchAllFarmsRequested event,
      Emitter<FarmSelectState> emit,
      ) async {

    emit(state.copyWith(status: () => FarmSelectStatus.loading));

    User user = await SharedPrefUtils().getUser();


    await _service.getFarms(user).then((companies)async{
      emit(state.copyWithoutMessage(
        status: () => FarmSelectStatus.success,
        farms: () => companies,
      ));
    }).catchError( (exception, stackTrace){

      emit(state.copyWith(
          status: () => FarmSelectStatus.failure,
          message: () => exception.toString()
      ));
    });

  }


  Future<void> _onSelectCompanyRequested(
      SelectFarmRequested event,
      Emitter<FarmSelectState> emit,
      ) async {


    await SharedPrefUtils().saveSelectedFarm(event.getFarm());

    emit(state.copyWithoutMessage(
          status: () => FarmSelectStatus.farmSelected,
          selectedFarm: () => event.getFarm()
      ));

  }

  Future<void> _onUnselectCompanyRequested(
      UnselectFarmRequested event,
      Emitter<FarmSelectState> emit,
      ) async {

    Farm selectedCompany =  await SharedPrefUtils().getSelectedFarm();

    SharedPrefUtils().removeSelectedFarm();

    emit(state.copyWithoutMessage(
      status: () => FarmSelectStatus.farmUnselected,
      selectedFarm: () => Farm.empty(),
    ));


  }
}