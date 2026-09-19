abstract class AuthRemoteDataSource {
  Future<void> verifyOtp({required String email, required String otp});

  Future<void> resendOtp({required String email});

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });
}
