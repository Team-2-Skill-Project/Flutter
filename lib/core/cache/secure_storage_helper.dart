import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// [SecureStorageHelper] handles **sensitive** encrypted local storage only.
class SecureStorageHelper {
  SecureStorageHelper({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  //! ─── Save ────────────────────────────────────────────────────────────────
  Future<void> saveSecureData({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  //! ─── Read ────────────────────────────────────────────────────────────────
  Future<String?> getSecureData({required String key}) async {
    return await _storage.read(key: key);
  }

  //! ─── Delete ──────────────────────────────────────────────────────────────
  Future<void> deleteSecureData({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAllSecureData() async {
    await _storage.deleteAll();
  }
}
