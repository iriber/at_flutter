
class UserDto{

  int id=0;
  String email="";
  String password="";
  String name="";

  UserDto(
      { this.email="",
        this.id=0,
        this.password="",
        this.name=""});

  UserDto.empty();

  UserDto.fromMap(Map<String, dynamic> item) {
    UserDto.fromJson(item);
  }

  UserDto.fromJson(dynamic item) {
    id=item["id"]??"";
    email=item["email"]??"";
    password=item["password"]??"";
    name=item["name"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'id':this.id,
      'email':this.email,
      'password':this.password,
      'name':this.name,};
  }
}