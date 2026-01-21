import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_config.dart';
import '../api_response.dart';
import '../network_error.dart';
import '../http_status.dart';
import '../helpers/connectivity_helper.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/logging_interceptor.dart';
import '../interceptors/error_interceptor.dart';
import 'upload_request.dart';
import 'upload_response.dart';
import 'upload_validator.dart';

class UploadClient {
  final AuthInterceptor _authInterceptor;
  final LoggingInterceptor _loggingInterceptor;
  final ErrorInterceptor _errorInterceptor;
  final UploadValidator _validator;

  UploadClient({
    AuthInterceptor? authInterceptor,
    LoggingInterceptor? loggingInterceptor,
    ErrorInterceptor? errorInterceptor,
    UploadValidator? validator,
  }) : _authInterceptor = authInterceptor ?? AuthInterceptor(),
       _loggingInterceptor = loggingInterceptor ?? LoggingInterceptor(),
       _errorInterceptor = errorInterceptor ?? ErrorInterceptor(),
       _validator = validator ?? UploadValidator();

  Future<ApiResponse<UploadResponse>> upload(UploadRequest request) async {
    if (!await ConnectivityHelper.isConnected) {
      return ApiResponse(
        error: NetworkError(
          status: HttpStatus.networkError,
          message: 'No internet connection',
        ),
      );
    }

    try {
      // 1. Validate File
      _validator.validate(
        request.fileName,
        request.fileBytes.lengthInBytes,
        request.mimeType,
      );

      // 2. Prepare Request
      final uri = Uri.parse('${ApiConfig.baseUrl}${request.endpoint}');
      final multipartRequest = http.MultipartRequest('POST', uri);

      // 3. Add Headers
      final defaultHeaders = ApiConfig.defaultHeaders;
      final authHeaders = await _authInterceptor.intercept(defaultHeaders);
      multipartRequest.headers.addAll(authHeaders);

      // 4. Add Metadata
      if (request.metadata != null) {
        multipartRequest.fields.addAll(request.metadata!);
      }

      // 5. Add File
      final multipartFile = http.MultipartFile.fromBytes(
        request.fieldName,
        request.fileBytes,
        filename: request.fileName,
        contentType: request.mimeType != null
            ? http.MediaType.parse(request.mimeType!)
            : null,
      );
      multipartRequest.files.add(multipartFile);

      _loggingInterceptor.logRequest(
        multipartRequest,
      ); // Custom handling in logging interceptor might be needed for Multipart

      // 6. Send Request
      final streamedResponse = await multipartRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      _loggingInterceptor.logResponse(response);

      // 7. Handle Response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        return ApiResponse(data: UploadResponse.fromJson(decoded));
      } else {
        return ApiResponse(error: _errorInterceptor.handleError(response));
      }
    } catch (e) {
      return ApiResponse(error: _errorInterceptor.handleException(e));
    }
  }
}
