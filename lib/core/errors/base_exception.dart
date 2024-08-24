class BaseException implements Exception {
  final String? message;

  final String? code;

  final dynamic error;

  BaseException({this.message, this.code, this.error});

  @override
  String toString() {
    if (error == null) return 'Exception';
    return 'Exception: $error';
  }

  factory BaseException.fromJson(final Map<String, dynamic> json) {
    return BaseException(
      message: json['message'],
      code: json['code'],
    );
  }

  factory BaseException.serverException() {
    return BaseException(
      message: 'Server Error',
      code: 'server_error',
    );
  }

  factory BaseException.unknown() {
    return BaseException(
      message: 'Unknown problem',
      code: 'unknown_error',
    );
  }
}
