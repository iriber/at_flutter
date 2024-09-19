import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_persistence/src/data/persistence/dao/fiona_dao.dart';

class FarmDAO extends FionaDAO<Farm>{

  FarmDAO(super.persistence);

  String get entityName => "Farm";

  String get createSQL => "CREATE TABLE ${this.entityName} (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, userId INTEGER NOT NULL)";

  @override
  Farm fromMap(Map<String, Object?> entity) {
    User user = User(id: (entity["userId"]??0) as int);
    return Farm(
        id: (entity["id"]??0) as int,
        name: (entity["name"]??"").toString(),
        user: user,
        );
  }

  @override
  getId(Farm entity) {
    return entity.id;
  }

  @override
  Map<String, Object?> toMap(Farm entity) {
    return {
        'id':(entity.id>0)?entity.id:null,
        'name':entity.name,
        'userId':(entity.user?.id??0),

    };

  }

}