import 'package:MatchIn/core/cache/secure_storage_helper.dart';
import 'package:MatchIn/core/cache/shared_preferences_helper.dart';
import 'package:MatchIn/core/networking/api_consumer.dart';
import 'package:MatchIn/core/networking/dio_consumer.dart';
import 'package:MatchIn/core/networking/network_info.dart';
import 'package:MatchIn/core/services/secure_storage_service.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/secure_storage_helper.dart';
import '../cache/shared_preferences_helper.dart';
import '../networking/api_consumer.dart';
import '../networking/network_info.dart';
import 'secure_storage_service.dart';
import 'shared_preferences_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // all objects you want to use only on time in your app

  //! ========= Features ==========
  //TODO: Put here all your features

  //! ======== External =========
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! ======== Core Storage Helpers =========
  getIt.registerLazySingleton<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(preferences: getIt()),
  );

  getIt.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());

  //! ======== Core Services =========
  getIt.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(getIt()),
  );

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(getIt()),
  );

  // ---> Network Info <---
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // ---> Network Client <---
  getIt.registerLazySingleton<Dio>(() => Dio());

  // ---> Api Consumer (abstract interface registration) <---
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: getIt(),
      secureStorageService: getIt(),
      sharedPreferencesService: getIt(),
    ),
  );
}
