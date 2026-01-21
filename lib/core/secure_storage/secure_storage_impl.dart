import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'secure_storage.dart';
import 'secure_storage_exception.dart';

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorageImpl({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw SecureStorageException('Failed to write key: $key', e);
    }
  }

  @override
  Future<String?> read({required String key}) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw SecureStorageException('Failed to read key: $key', e);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw SecureStorageException('Failed to delete key: $key', e);
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw SecureStorageException('Failed to delete all keys', e);
    }
  }
}
