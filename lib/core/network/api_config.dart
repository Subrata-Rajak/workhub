class ApiConfig {
  static const String baseUrl = 'https://api.workhub.local/api/v1';
  static const int connectTimeout = 10000; // 10s
  static const int receiveTimeout = 10000; // 10s

  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
