import 'package:equatable/equatable.dart';

import '../../../domain/menu.dart';


enum MenuStatus { initial, loading, success, failure, loginRequired }

class MenuState extends Equatable {

  final MenuStatus status;
  final List<Menu> mainMenu;
  final List<Menu> sidebarMenu;
  String? message;

  MenuState({
    this.status = MenuStatus.initial,
    this.mainMenu = const [],
    this.sidebarMenu = const [],
    this.message="",
  });

  MenuState copyWith({
    MenuStatus Function()? status,
    List<Menu> Function()? mainMenu,
    List<Menu> Function()? sidebarMenu,
    String Function()? message
  }) {
    return MenuState(
      status: status != null ? status() : this.status,
      mainMenu: mainMenu != null ? mainMenu() : this.mainMenu,
      sidebarMenu: sidebarMenu != null ? sidebarMenu() : this.sidebarMenu,
      message: message != null ? message() : this.message,
    );
  }

  MenuState copyWithoutMessage({
    MenuStatus Function()? status,
    List<Menu> Function()? mainMenu,
    List<Menu> Function()? sidebarMenu,
  }) {
    return MenuState(
        status: status != null ? status() : this.status,
        mainMenu: mainMenu != null ? mainMenu() : this.mainMenu,
        sidebarMenu: sidebarMenu != null ? sidebarMenu() : this.sidebarMenu
    );
  }

  @override
  List<Object?> get props => [
    status,
    mainMenu,
    sidebarMenu,
    message
  ];
}