import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'api_response.dart';
import 'http_status.dart';
import 'network_error.dart';
import 'helpers/connectivity_helper.dart';
import 'helpers/timeout_helper.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class ApiClient {
  final http.Client _client;
  final AuthInterceptor _authInterceptor;
  final LoggingInterceptor _loggingInterceptor;
  final ErrorInterceptor _errorInterceptor;

  ApiClient({
    http.Client? client,
    AuthInterceptor? authInterceptor,
    LoggingInterceptor? loggingInterceptor,
    ErrorInterceptor? errorInterceptor,
  }) : _client = client ?? http.Client(),
       _authInterceptor = authInterceptor ?? AuthInterceptor(),
       _loggingInterceptor = loggingInterceptor ?? LoggingInterceptor(),
       _errorInterceptor = errorInterceptor ?? ErrorInterceptor();

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _request<T>(
      (mergedHeaders) => _client.get(_uri(endpoint), headers: mergedHeaders),
    );
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _request<T>(
      (mergedHeaders) => _client.post(
        _uri(endpoint),
        headers: mergedHeaders,
        body: jsonEncode(body),
      ),
    );
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _request<T>(
      (mergedHeaders) => _client.put(
        _uri(endpoint),
        headers: mergedHeaders,
        body: jsonEncode(body),
      ),
    );
  }

  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _request<T>(
      (mergedHeaders) => _client.patch(
        _uri(endpoint),
        headers: mergedHeaders,
        body: jsonEncode(body),
      ),
    );
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _request<T>(
      (mergedHeaders) => _client.delete(_uri(endpoint), headers: mergedHeaders),
    );
  }

  Future<ApiResponse<T>> _request<T>(
    Future<http.Response> Function(Map<String, String> headers) requestFn,
  ) async {
    if (!await ConnectivityHelper.isConnected) {
      return ApiResponse(
        error: NetworkError(
          status: HttpStatus.networkError,
          message: 'No internet connection',
        ),
      );
    }

    try {
      final defaultHeaders = ApiConfig.defaultHeaders;
      final authHeaders = await _authInterceptor.intercept(defaultHeaders);

      // Execute request with timeout
      final response = await requestFn(
        authHeaders,
      ).timeout(TimeoutHelper.receiveTimeout);

      _loggingInterceptor.logResponse(response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = _parseResponse<T>(response);
        return ApiResponse(data: data);
      } else {
        return ApiResponse(error: _errorInterceptor.handleError(response));
      }
    } catch (e) {
      return ApiResponse(error: _errorInterceptor.handleException(e));
    }
  }

  Uri _uri(String endpoint) {
    return Uri.parse('${ApiConfig.baseUrl}$endpoint');
  }

  T? _parseResponse<T>(http.Response response) {
    if (response.body.isEmpty) return null;
    try {
      final decoded = jsonDecode(response.body);
      return decoded as T;
    } catch (e) {
      // If T is String, return body
      if (T == String) return response.body as T;
      throw FormatException('Failed to parse response: $e');
    }
  }
}
