import 'package:MatchIn/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, Unit>> resendOtp({required String email});

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String newPassword,
  });
}
