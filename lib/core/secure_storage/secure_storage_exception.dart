class SecureStorageException implements Exception {
  final String message;
  final Object? originalError;

  SecureStorageException(this.message, [this.originalError]);

  @override
  String toString() =>
      'SecureStorageException: $message ${originalError != null ? '($originalError)' : ''}';
}
