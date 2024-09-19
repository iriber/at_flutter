


import 'package:agro_tracking_flutter/src/data/connectivity.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

abstract class DataProxy<T extends GenericModel>{

  static const String local = 'local';
  static const String remote = 'remote';

  final FionaLogger logger = DependencyManager().get<FionaLogger>();

  Future<List<T>> getData(Future<List<T>> Function() getRemoteData,Future<List<T>>  Function() getLocalData, Future<void> Function(List<T> remotes) syncLocalData) async{

    List<T> entities = List.empty(growable: true);

    final hasConnection = await ConnectivityService().checkInternetConnection();
    if(hasConnection){

      await getRemoteData().then(( remoteEntities ) async{

        await syncLocalData(remoteEntities).then((value)=>{
          logger.d("Local data synchronized")
        }).catchError((error, stackTrace){
          logger.d("Exception on sync local data: $error");
        });

      }).catchError((error, stackTrace){
        logger.d("Exception on getting remote data: $error");
      });

    }

    await getLocalData().then(( localEntities )  {
      entities=localEntities;
    }).catchError((error, stackTrace){
      logger.d("Exception on getting local data: $error");
    });

    logger.d("Total data: ${entities.length}");
    return entities;
  }


  Future<T?> findDataBy<U>(
      U findThis,
      Future<T?> Function(U findThis) getRemoteData,
      Future<T?>  Function(U findThis) getLocalData,
      Future<void> Function(T remotes) syncLocalData
      ) async{

    T? entity;;

    final hasConnection = await ConnectivityService().checkInternetConnection();
    if(hasConnection){

      await getRemoteData(findThis).then(( remoteEntity ) async{

        if(remoteEntity!=null){
          await syncLocalData(remoteEntity).then((value)=>{
            logger.d("Local data synchronized")
          }).catchError((error, stackTrace){
            logger.d("Exception on sync local data: $error");
          });
        }


      }).catchError((error, stackTrace){
        logger.d("Exception on getting remote data: $error");
      });

    }

    await getLocalData(findThis).then(( localEntity )  {
      entity=localEntity;
    }).catchError((error, stackTrace){
      logger.d("Exception on getting local data: $error");
    });


    return entity;
  }

  Future<List<T>> getDataBy<U>(
      U findThis,
      Future<List<T>> Function(U findThis) getRemoteData,
      Future<List<T>> Function(U findThis) getLocalData,
      Future<void> Function(List<T> remotes) syncLocalData,
      ) async {

    List<T> entities = List.empty(growable: true);

    final hasConnection = await ConnectivityService().checkInternetConnection();
    if(hasConnection){

      await getRemoteData(findThis).then(( remoteEntities ) async{

        await syncLocalData(remoteEntities).then((value)=>{
          logger.d("Local data synchronized")
        }).catchError((error, stackTrace){
          logger.d("Exception on sync local data: $error");
        });

      }).catchError((error, stackTrace){
        logger.d("Exception on getting remote data: $error");
      });

    }

    await getLocalData(findThis).then(( localEntities )  {
      entities=localEntities;
    }).catchError((error, stackTrace){
      logger.d("Exception on getting local data: $error");
    });

    logger.d("Total data: ${entities.length}");
    return entities;
  }

}
