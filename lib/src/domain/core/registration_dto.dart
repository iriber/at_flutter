
class RegistrationDto{

  String name="";
  String email="";
  String password="";

  RegistrationDto(
      { this.name="",
        this.email="",
        this.password=""});

  RegistrationDto.empty();

  RegistrationDto.fromMap(Map<String, dynamic> item) {
    RegistrationDto.fromJson(item);
  }

  RegistrationDto.fromJson(dynamic item) {
    name=item["name"]??"";
    email=item["email"]??"";
    password=item["password"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'name':this.name,
      'email':this.email,
      'password':this.password,};
  }
}