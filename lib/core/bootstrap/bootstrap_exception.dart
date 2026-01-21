class BootstrapException implements Exception {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;

  BootstrapException(this.message, {this.originalError, this.stackTrace});

  @override
  String toString() =>
      'BootstrapException: $message ${originalError != null ? '($originalError)' : ''}';
}
