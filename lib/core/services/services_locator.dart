import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_match/core/cache/cache_helper.dart';
import 'package:skill_match/core/networking/dio_consumer.dart';
import 'package:skill_match/core/networking/network_info.dart';

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
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ---> Cache Helper <---
  getIt.registerLazySingleton(() => CacheHelper().init());

  // ---> Dio <---
  getIt.registerLazySingleton(() => Dio());
  //consumer
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt()));
}
