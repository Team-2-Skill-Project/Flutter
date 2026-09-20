import 'package:MatchIn/core/networking/api_consumer.dart';
import 'package:MatchIn/core/networking/api_end_points.dart';
import 'package:MatchIn/features/auth/data/data_sources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<void> verifyOtp({required String email, required String otp}) async {
    await apiConsumer.post(
      EndPoint.verifyOtp,
      data: {ApiKey.email: email, ApiKey.otp: otp},
    );
  }

  @override
  Future<void> resendOtp({required String email}) async {
    await apiConsumer.post(EndPoint.resendOtp, data: {ApiKey.email: email});
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    await apiConsumer.post(
      EndPoint.resetPassword,
      data: {ApiKey.email: email, ApiKey.newPassword: newPassword},
    );
  }
}
