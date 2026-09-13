import 'package:MatchIn/core/cache/cache_key.dart';
import 'package:MatchIn/core/cache/secure_storage_helper.dart';

import '../cache/cache_key.dart';
import '../cache/secure_storage_helper.dart';

class SecureStorageService {
  const SecureStorageService(this._secureStorageHelper);

  final SecureStorageHelper _secureStorageHelper;

  // --- Save access token and refresh token as secure data ---
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureStorageHelper.saveSecureData(
      key: CacheKey.accessToken,
      value: accessToken,
    );
    await _secureStorageHelper.saveSecureData(
      key: CacheKey.refreshToken,
      value: refreshToken,
    );
  }

  // --- Get access token ---
  Future<String?> getAccessToken() async {
    return await _secureStorageHelper.getSecureData(key: CacheKey.accessToken);
  }

  // --- Get refresh token ---
  Future<String?> getRefreshToken() async {
    return await _secureStorageHelper.getSecureData(key: CacheKey.refreshToken);
  }

  // --- Delete access token and refresh token ---
  Future<void> deleteTokens() async {
    await _secureStorageHelper.deleteSecureData(key: CacheKey.accessToken);
    await _secureStorageHelper.deleteSecureData(key: CacheKey.refreshToken);
  }
}

