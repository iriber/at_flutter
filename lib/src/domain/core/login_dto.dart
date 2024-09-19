
class LoginDto{

  String email="";
  String password="";

  LoginDto(
      { this.email="",
        this.password=""});

  LoginDto.empty();

  LoginDto.fromMap(Map<String, dynamic> item) {
    LoginDto.fromJson(item);
  }

  LoginDto.fromJson(dynamic item) {
    email=item["email"]??"";
    password=item["password"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'email':this.email,
      'password':this.password,};
  }
}