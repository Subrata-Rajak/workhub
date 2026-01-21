import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LoggingInterceptor {
  void logRequest(http.BaseRequest request) {
    if (kDebugMode) {
      print('--> ${request.method} ${request.url}');
      print('Headers: ${request.headers}');
      if (request is http.Request && request.body.isNotEmpty) {
        // Only log body for standard requests
        print('Body: ${request.body}');
      }
      print('--> END ${request.method}');
    }
  }

  void logResponse(http.Response response) {
    if (kDebugMode) {
      print('<-- ${response.statusCode} ${response.request?.url}');
      print('Body: ${response.body}');
      print('<-- END HTTP');
    }
  }
}
