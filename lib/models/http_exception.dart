class HttpException implements Exception{
  late final String message;

  HttpException(this.message);

@override
  String toString() {
    // TODO: implement toString
    return  message;
  }
}