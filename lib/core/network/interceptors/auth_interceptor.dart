class AuthInterceptor {
  // Placeholder for retrieving token from secure storage
  Future<String?> get _token async {
    // In a real app, this would get the token from SecureStorage
    return 'mock-token';
  }

  Future<Map<String, String>> intercept(Map<String, String> headers) async {
    final token = await _token;
    if (token != null) {
      return {...headers, 'Authorization': 'Bearer $token'};
    }
    return headers;
  }
}
