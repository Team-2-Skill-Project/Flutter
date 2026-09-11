import 'package:MatchIn/core/cache/secure_storage_helper.dart';
import 'package:MatchIn/core/cache/shared_preferences_helper.dart';

/// [CacheHelper] acts as a unified wrapper delegating to
/// [SharedPreferencesHelper] for non-sensitive data and
/// [SecureStorageHelper] for sensitive data.
@Deprecated('Use SharedPreferencesHelper or SecureStorageHelper instead')
class CacheHelper {
  CacheHelper({
    required this.sharedPreferencesHelper,
    required this.secureStorageHelper,
  });

  final SharedPreferencesHelper sharedPreferencesHelper;
  final SecureStorageHelper secureStorageHelper;

  //? ====================================================
  //? ================ Shared Preferences ================
  //? ====================================================

  Future<bool> saveData({required String key, required dynamic value}) =>
      sharedPreferencesHelper.saveData(key: key, value: value);

  dynamic getData({required String key}) =>
      sharedPreferencesHelper.getData(key: key);

  String? getString({required String key}) =>
      sharedPreferencesHelper.getString(key: key);

  int? getInt({required String key}) =>
      sharedPreferencesHelper.getInt(key: key);

  bool? getBool({required String key}) =>
      sharedPreferencesHelper.getBool(key: key);

  double? getDouble({required String key}) =>
      sharedPreferencesHelper.getDouble(key: key);

  List<String>? getStringList({required String key}) =>
      sharedPreferencesHelper.getStringList(key: key);

  bool containsKey({required String key}) =>
      sharedPreferencesHelper.containsKey(key: key);

  Future<bool> deleteData({required String key}) =>
      sharedPreferencesHelper.deleteData(key: key);

  Future<bool> clearAllData() => sharedPreferencesHelper.clearAllData();

  Future<bool> updateData({required String key, required dynamic value}) =>
      sharedPreferencesHelper.updateData(key: key, value: value);

  //? ====================================================
  //? ================== Secure Storage ==================
  //? ====================================================

  Future<void> saveSecureData({
    required String key,
    required String value,
  }) =>
      secureStorageHelper.saveSecureData(key: key, value: value);

  Future<String?> getSecureData({required String key}) =>
      secureStorageHelper.getSecureData(key: key);

  Future<void> deleteSecureData({required String key}) =>
      secureStorageHelper.deleteSecureData(key: key);

  Future<void> deleteAllSecureData() =>
      secureStorageHelper.deleteAllSecureData();
}
