// ignore_for_file: constant_identifier_names

class BaseException implements Exception {
  /// The original error/exception object; It's usually not null when `type`
  final String? message;
  final dynamic error;
  final int? code;

  BaseException([this.message, this.code, this.error]);

  // BaseException.fromErrorCode(String code)
  //     : error = ErrorMessage.errCodeToMessage(code);

  @override
  String toString() {
    if (error == null) return 'Exception';
    return 'Exception: $error';
  }
}
