abstract class GenericModel extends Object{
  int id;
  int? localId;
  bool isSyncrhonized=false;
  GenericModel(this.id, {this.localId, this.isSyncrhonized=false});
}