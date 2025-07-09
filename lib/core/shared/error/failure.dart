class Failure {
  final Object? exception;
  final String? message;

  Failure({this.message, this.exception});

  @override
  String toString() {
    return 'Failure: ${exception.toString()}';
  }
}
