import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MatchIn/core/cache/cache_helper.dart';
import 'package:MatchIn/core/networking/dio_consumer.dart';
import 'package:MatchIn/core/networking/network_info.dart';

// Create a global instance (or use GetIt.instance)
final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // all objects you want to use only on time in your app

  //! ========= Features ==========
  //TODO: Put here all your features

  //! ======== Core =========
  // ---> Network Info <---
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! ======= External =========

  // ---> Shared Preferences <---
  // Obtain a single SharedPreferences instance and register it.
  // CacheHelper receives this same instance via constructor injection so that
  // only ONE SharedPreferences object exists throughout the app.
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ---> Cache Helper <---
  // Inject the already-initialized SharedPreferences instance — no second
  // getInstance() call and no Future<void> registration mistake.
  getIt.registerLazySingleton<CacheHelper>(
    () => CacheHelper(preferences: sharedPreferences),
  );

  //! ======== Core =========

  // ---> Network Info <---
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // ---> Dio <---
  getIt.registerLazySingleton<Dio>(() => Dio());

  // ---> Dio Consumer <---
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt()));

  //! ========= Features ==========
  //TODO: Put here all your features
}
