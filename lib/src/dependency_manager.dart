
import 'package:get_it/get_it.dart';

class DependencyManager {

  DependencyManager._internal();

  static final DependencyManager _singleton = DependencyManager._internal();
  final getIt = GetIt.instance;

  factory DependencyManager() {
    _singleton.allowOverride();
    return _singleton;
  }

  void allowOverride(){
    getIt.allowReassignment=true;
  }

  T get<T extends Object>({String? instanceName}){
     return getIt.get<T>(instanceName: instanceName);
  }

  T getWithParam<T extends Object, P1>(dynamic p,{String? instanceName}){
    return getIt.get<T>(param1: p,instanceName: instanceName);
  }

  T getWith2Param<T extends Object, P1, P2>(dynamic p1, dynamic p2,{String? instanceName}){
    return getIt.get<T>(param1: p1, param2: p2,instanceName: instanceName);
  }

  bool isRegistered<T extends Object>({String? instanceName}){
    return getIt.isRegistered<T>(instanceName: instanceName);
  }

  void registerLazySingleton<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}){
    getIt.registerLazySingleton<T>(factoryFunc, instanceName: instanceName );
  }

  void registerLazySingletonIfNotExist<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}){
    if(!isRegistered<T>(instanceName: instanceName)){
      getIt.registerLazySingleton<T>(factoryFunc, instanceName: instanceName );
    }

  }

  void registerFactoryIfNotExist<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}){
    if(!isRegistered<T>(instanceName: instanceName)) {
      getIt.registerFactory<T>(factoryFunc, instanceName: instanceName);
    }
  }

  void registerFactory<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}){
    getIt.registerFactory<T>(factoryFunc, instanceName: instanceName );

  }

  void registerFactoryParam<T extends Object, P1, P2>(
      FactoryFuncParam<T, P1, P2> factoryFunc, {
        String? instanceName,
      }){
    getIt.registerFactoryParam<T,P1,P2>(factoryFunc, instanceName: instanceName);

  }

  void registerFactoryParamIfNotExist<T extends Object, P1, P2>(
      FactoryFuncParam<T, P1, P2> factoryFunc, {
        String? instanceName,
      }){
    if(!isRegistered<T>(instanceName: instanceName)) {
      getIt.registerFactoryParam<T, P1, P2>(
          factoryFunc, instanceName: instanceName);
    }
  }
}



