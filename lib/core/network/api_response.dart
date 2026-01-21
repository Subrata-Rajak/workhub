import 'network_error.dart';

class ApiResponse<T> {
  final T? data;
  final NetworkError? error;

  ApiResponse({this.data, this.error});

  bool get isSuccess => error == null;
}
