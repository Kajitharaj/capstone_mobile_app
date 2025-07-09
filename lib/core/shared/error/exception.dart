class ServerException implements Exception {
  final String? error;
  final String errorCode;

  ServerException({required this.errorCode, this.error});

  @override
  String toString() {
    return '$error';
  }
}
