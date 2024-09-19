

class AtException implements Exception{

  String message;

  AtException({String this.message="At Exception"});

  @override
  String toString() {
    return message;
  }
}