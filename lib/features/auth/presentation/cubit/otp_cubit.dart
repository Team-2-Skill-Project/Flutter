import 'package:MatchIn/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:MatchIn/features/auth/domain/use_cases/resend_otp_use_case.dart';
import 'package:MatchIn/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:MatchIn/features/auth/domain/use_cases/verify_password_reset_otp_use_case.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyPasswordResetOtpUseCase,
  }) : super(const OtpInitial());

  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyPasswordResetOtpUseCase verifyPasswordResetOtpUseCase;

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(const OtpLoading());

    final result = await verifyOtpUseCase(email: email, otp: otp);

    result.fold(
      (failure) => emit(OtpVerificationError(message: failure.message)),
      (_) => emit(const OtpVerificationSuccess()),
    );
  }

  Future<void> resendOtp({required String email}) async {
    final result = await resendOtpUseCase(email: email);

    result.fold(
      (failure) => emit(OtpResendError(message: failure.message)),
      (_) => emit(const OtpResendSuccess()),
    );
  }

  Future<void> requestPasswordReset({required String email}) async {
    final result = await forgotPasswordUseCase(email: email);

    result.fold(
      (failure) => emit(OtpResendError(message: failure.message)),
      (_) => emit(const OtpResendSuccess()),
    );
  }

  Future<void> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    emit(const OtpLoading());

    final result = await verifyPasswordResetOtpUseCase(
      email: email,
      otp: otp,
    );

    result.fold(
      (failure) => emit(OtpVerificationError(message: failure.message)),
      (_) => emit(const OtpVerificationSuccess()),
    );
  }
}
