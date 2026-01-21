class UploadResponse {
  final String fileId;
  final String url;
  final int size;
  final String type;

  UploadResponse({
    required this.fileId,
    required this.url,
    required this.size,
    required this.type,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      fileId: json['id'] ?? '',
      url: json['url'] ?? '',
      size: json['size'] ?? 0,
      type: json['type'] ?? '',
    );
  }
}
