import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_persistence/src/data/persistence/dao/fiona_dao.dart';

class PaddockDAO extends FionaDAO<Paddock>{

  PaddockDAO(super.persistence);

  String get entityName => "Paddock";

  String get createSQL => "CREATE TABLE ${this.entityName} (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, farmId INTEGER NOT NULL)";

  @override
  Paddock fromMap(Map<String, Object?> entity) {

    return Paddock(
        id: (entity["id"]??0) as int,
        name: (entity["name"]??"").toString(),
        farmId: (entity["farmId"]??0) as int,
        );
  }

  @override
  getId(Paddock entity) {
    return entity.id;
  }

  @override
  Map<String, Object?> toMap(Paddock entity) {
    return {
        'id':(entity.id>0)?entity.id:null,
        'name':entity.name,
        'farmId':entity.farmId??0,

    };

  }

}