
class FarmDTO{

  int id=0;
  String name="";
  int userId=0;

  FarmDTO(
      { this.id=0,
        this.userId=0,
        this.name="",});

  FarmDTO.empty();

  FarmDTO.fromMap(Map<String, dynamic> item) {
    FarmDTO.fromJson(item);
  }

  FarmDTO.fromJson(dynamic item) {
    id=item["id"]??0;
    name=item["name"]??"";
    userId=item["userId"]??0;
  }

  Map<String, Object> toMap(){
    return {
      'name':this.name,
      'id':this.id,
      'userId': this.userId,};
  }
}