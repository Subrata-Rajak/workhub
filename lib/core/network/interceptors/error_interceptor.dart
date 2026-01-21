import 'package:http/http.dart' as http;
import '../http_status.dart';
import '../network_error.dart';

class ErrorInterceptor {
  NetworkError handleError(http.Response response) {
    final statusCode = response.statusCode;

    // 200-299 is success usually, but this interceptor is called when we suspect error or want to validate.
    // However, usually we check status code first.

    HttpStatus status;
    String message = 'Unknown Error';

    switch (statusCode) {
      case 400:
        status = HttpStatus.badRequest;
        message = 'Bad Request';
        break;
      case 401:
        status = HttpStatus.unauthorized;
        message = 'Unauthorized';
        break;
      case 403:
        status = HttpStatus.forbidden;
        message = 'Forbidden';
        break;
      case 404:
        status = HttpStatus.notFound;
        message = 'Not Found';
        break;
      case 500:
      case 502:
      case 503:
      case 504:
        status = HttpStatus.serverError;
        message = 'Server Error';
        break;
      default:
        status = HttpStatus.unknown;
        message = 'Unexpected error: $statusCode';
    }

    return NetworkError(status: status, message: message, code: statusCode);
  }

  NetworkError handleException(Object exception) {
    return NetworkError(
      status: HttpStatus.networkError,
      message: exception.toString(),
    );
  }
}
