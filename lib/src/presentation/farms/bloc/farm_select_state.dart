import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:equatable/equatable.dart';

enum FarmSelectStatus { initial, loading, success, failure, farmUnselected, farmSelected, connectivityFailure, companySelectedClose }

class FarmSelectState extends Equatable {

  final FarmSelectStatus status;
  final List<Farm> farms;
  final Farm? selectedFarm;
  String? message;

  FarmSelectState({
    this.status = FarmSelectStatus.initial,
    this.farms = const [],
    this.selectedFarm,
    this.message="",
  });

  FarmSelectState copyWith({
    FarmSelectStatus Function()? status,
    List<Farm> Function()? farms,
    Farm Function()? selectedFarm,
    String Function()? message
  }) {
    return FarmSelectState(
      status: status != null ? status() : this.status,
      farms: farms != null ? farms() : this.farms,
      selectedFarm: selectedFarm != null ? selectedFarm() : this.selectedFarm,
      message: message != null ? message() : this.message,
    );
  }

  FarmSelectState copyWithoutMessage({
    FarmSelectStatus Function()? status,
    List<Farm> Function()? farms,
    Farm Function()? selectedFarm,
  }) {
    return FarmSelectState(
      status: status != null ? status() : this.status,
      farms: farms != null ? farms() : this.farms,
      selectedFarm: selectedFarm != null ? selectedFarm() : this.selectedFarm,
    );
  }

  @override
  List<Object?> get props => [
    status,
    farms,
    selectedFarm,
    message
  ];

  bool hasCompanySelected(){
    return (selectedFarm!=null && (selectedFarm?.isNotEmpty()??false));
  }

}