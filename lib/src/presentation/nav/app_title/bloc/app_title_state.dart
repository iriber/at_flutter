import 'package:equatable/equatable.dart';



enum AppTitleStatus { defaultTitle, titleChanged }

class AppTitleState extends Equatable {

  final AppTitleStatus status;
  String? title;

  AppTitleState({
    this.status = AppTitleStatus.titleChanged,
    this.title="",
  });

  AppTitleState copyWith({
    AppTitleStatus Function()? status,
    String Function()? title
  }) {
    return AppTitleState(
      status: status != null ? status() : this.status,
      title: title != null ? title() : this.title,
    );
  }


  @override
  List<Object?> get props => [
    status,
    title
  ];
}