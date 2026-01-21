import 'dart:typed_data';

class UploadRequest {
  final String endpoint;
  final String fieldName;
  final Uint8List fileBytes;
  final String fileName;
  final String? mimeType;
  final Map<String, String>? metadata;

  UploadRequest({
    required this.endpoint,
    required this.fieldName,
    required this.fileBytes,
    required this.fileName,
    this.mimeType,
    this.metadata,
  });
}
