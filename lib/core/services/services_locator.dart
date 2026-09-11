import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a global instance (or use GetIt.instance)
final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // all objects you want to use only on time in your app

  //! ========= Features ==========
  //TODO: Put here all your features

  //! ======== Core =========
  // ---> Network Info <---
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt()),
  );

  //! ======= External =========

  // ---> Shared Preferences <---
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ---> Cache Helper <---
  getIt.registerLazySingleton(() => CacheHelper(preferences: getIt()));

  // ---> Dio <---
  getIt.registerLazySingleton(() => Dio());
  //consumer
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt()));
}
