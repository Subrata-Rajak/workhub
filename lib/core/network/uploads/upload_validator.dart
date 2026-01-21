import 'package:mime/mime.dart';
import '../network_error.dart';
import '../http_status.dart';

class UploadValidator {
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxPdfSize = 25 * 1024 * 1024; // 25MB
  static const int maxVideoSize = 100 * 1024 * 1024; // 100MB

  void validate(String fileName, int fileSizeInBytes, String? mimeType) {
    final extension = fileName.split('.').last.toLowerCase();

    // Validate Extension & Mime (Basic check)
    // Note: mimeType might be guessed from extension if not provided,
    // real validation should happen on server or via magic bytes if critical.
    final derivedMime = mimeType ?? lookupMimeType(fileName);

    if (derivedMime == null) {
      throw NetworkError(
        status: HttpStatus.badRequest,
        message: 'Unknown file type',
      );
    }

    if (derivedMime.startsWith('image/')) {
      if (fileSizeInBytes > maxImageSize) {
        throw NetworkError(
          status: HttpStatus.badRequest,
          message: 'Image size exceeds 10MB limit',
        );
      }
      if (!['jpg', 'png', 'webp', 'jpeg'].contains(extension)) {
        throw NetworkError(
          status: HttpStatus.badRequest,
          message: 'Unsupported image format',
        );
      }
    } else if (derivedMime == 'application/pdf') {
      if (fileSizeInBytes > maxPdfSize) {
        throw NetworkError(
          status: HttpStatus.badRequest,
          message: 'PDF size exceeds 25MB limit',
        );
      }
    } else if (derivedMime == 'video/mp4') {
      if (fileSizeInBytes > maxVideoSize) {
        throw NetworkError(
          status: HttpStatus.badRequest,
          message: 'Video size exceeds 100MB limit',
        );
      }
    } else {
      throw NetworkError(
        status: HttpStatus.badRequest,
        message: 'Unsupported file type: $derivedMime',
      );
    }
  }
}
