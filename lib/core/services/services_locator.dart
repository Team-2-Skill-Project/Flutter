import 'package:MatchIn/core/cache/secure_storage_helper.dart';
import 'package:MatchIn/core/cache/shared_preferences_helper.dart';
import 'package:MatchIn/core/networking/api_consumer.dart';
import 'package:MatchIn/core/networking/dio_consumer.dart';
import 'package:MatchIn/core/networking/network_info.dart';
import 'package:MatchIn/core/services/file_picker_service.dart';
import 'package:MatchIn/core/services/secure_storage_service.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/features/auth/data/data_sources/auth_mock_remote_data_source_impl.dart';
import 'package:MatchIn/features/auth/data/data_sources/auth_remote_data_source.dart';
// ignore: unused_import
import 'package:MatchIn/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:MatchIn/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:MatchIn/features/auth/domain/repositories/auth_repository.dart';
import 'package:MatchIn/features/auth/domain/use_cases/resend_otp_use_case.dart';
import 'package:MatchIn/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:MatchIn/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:MatchIn/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // all objects you want to use only on time in your app

  //! ========= Features ==========
  // =========================================================================
  // 🔄 Auth Feature (1-Line Toggle: switch between Mock and Real API below)
  // =========================================================================
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthMockRemoteDataSourceImpl(),
    // () => AuthRemoteDataSourceImpl(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(repository: getIt()),
  );

  getIt.registerFactory<OtpCubit>(
    () => OtpCubit(
      verifyOtpUseCase: getIt(),
      resendOtpUseCase: getIt(),
    ),
  );
  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(resetPasswordUseCase: getIt()),
  );

  //! ======== External =========
  final sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  //! ======== Core Storage Helpers =========
  getIt.registerLazySingleton<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(preferences: getIt()),
  );

  getIt.registerLazySingleton<SecureStorageHelper>(
    () => SecureStorageHelper(),
  );

  //! ======== Core Services =========
  getIt.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(getIt()),
  );

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(getIt()),
  );

  // ---> Network Info <---
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );

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

  getIt.registerLazySingleton<FilePickerService>(
    () => FilePickerService(),
  );
}
