
class LotDto{

  int id=0;
  String name="";
  LotDto(
      { this.id=0,
        this.name=""});

  LotDto.empty();

  LotDto.fromMap(Map<String, dynamic> item) {
    LotDto.fromJson(item);
  }

  LotDto.fromJson(dynamic item) {
    id=item["id"]??0;
    name=item["name"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'name':this.name,
      'id':this.id};
  }
}