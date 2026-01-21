import 'http_status.dart';

class NetworkError implements Exception {
  final HttpStatus status;
  final String message;
  final int? code;

  NetworkError({required this.status, required this.message, this.code});

  @override
  String toString() =>
      'NetworkError(status: $status, message: $message, code: $code)';
}
