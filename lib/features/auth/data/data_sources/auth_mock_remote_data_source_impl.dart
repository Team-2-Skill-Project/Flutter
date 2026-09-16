import 'dart:async';
import 'package:MatchIn/core/errors/error_model.dart';
import 'package:MatchIn/core/errors/exceptions.dart';
import 'package:MatchIn/features/auth/data/data_sources/auth_remote_data_source.dart';

class AuthMockRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Simulated error for testing invalid OTP:
    if (otp == '000000') {
      throw ServerException(
        errorModel: ErrorModel(
          statusCode: 400,
          errorMessage: 'Invalid verification code',
        ),
      );
    }
  }

  @override
  Future<void> resendOtp({
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (newPassword.length < 8) {
      throw ServerException(
        errorModel: ErrorModel(
          statusCode: 400,
          errorMessage: 'Password must be at least 8 characters',
        ),
      );
    }
  }
}
