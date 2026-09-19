import 'dart:async';

import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_state.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_animated_fields/otp_animated_fields.dart';

/// OTP length expected by the authentication backend.
const int _kOtpLength = 6;

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key, this.email = 'user@example.com'});

  final String email;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  // ── OTP animated field controller ──────────────────────────────────────
  final OtpAnimatedController _otpController = OtpAnimatedController();

  // ── Resend countdown timer ─────────────────────────────────────────────
  int _secondsRemaining = 60;
  Timer? _countdownTimer;

  // ── Tracks whether a verification is already in flight ────────────────
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  // ── Timer helpers ───────────────────────────────────────────────────────

  void _startTimer() {
    _countdownTimer?.cancel();
    setState(() => _secondsRemaining = 60);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  // ── Resend handler ──────────────────────────────────────────────────────

  void _onResend() {
    if (_secondsRemaining == 0 && !_isVerifying) {
      context.read<OtpCubit>().resendOtp(email: widget.email);
      _startTimer();
    }
  }

  // ── OTP submission ──────────────────────────────────────────────────────

  void _onCompleted(String code) {
    if (_isVerifying) return; // prevent duplicate requests
    _isVerifying = true;
    context.read<OtpCubit>().verifyOtp(email: widget.email, otp: code);
  }

  // ── Navigation after success animation ─────────────────────────────────

  void _onOtpStatusChanged(OtpStatus status) {
    if (status == OtpStatus.success) {
      getIt<SharedPreferencesService>().setLoggedIn(true);
      context.go(AppRoutes.kHomeView);
    }
    if (status == OtpStatus.idle) {
      // Returned to idle after error — allow re-verification
      setState(() => _isVerifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          // Trigger success animation; navigation happens in onStatusChanged
          // after the animation finishes.
          _otpController.succeed();
        } else if (state is OtpVerificationError) {
          // Trigger error (shake) animation, then re-enable input.
          _otpController.fail();
          CustomSnackBar.showError(context, message: state.message);
        } else if (state is OtpResendSuccess) {
          _otpController.reset();
          CustomSnackBar.showSuccess(
            context,
            message: S.of(context).resendCode,
          );
        } else if (state is OtpResendError) {
          CustomSnackBar.showError(context, message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CustomAppBar(title: S.of(context).enterVerificationCode),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header icon ──────────────────────────────────────────
                Center(
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.verified_user_outlined,
                      color: colorScheme.onPrimary,
                      size: 28.sp,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Heading & subtitle ───────────────────────────────────
                Text(
                  S.of(context).enterVerificationCode,
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: 4.h),
                Text(
                  S.of(context).sentCodeToEmail,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 24.h),

                // ── OTP input card ───────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colorScheme.outline, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Code label ────────────────────────────────────
                      Text(
                        S.of(context).verificationCodeLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurface,
                          letterSpacing: 0.55,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // ── Animated OTP field ────────────────────────────
                      // Digits stay LTR inside an RTL locale automatically;
                      // the package handles that internally.
                      Center(
                        child: OtpAnimatedField(
                          controller: _otpController,
                          length: _kOtpLength,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          onCompleted: _onCompleted,
                          onStatusChanged: _onOtpStatusChanged,
                          semanticLabels: OtpSemanticLabels(
                            field: S.of(context).verificationCodeLabel,
                          ),
                          // Let the field follow the surrounding Material
                          // theme: brightness selects light/dark preset,
                          // colorScheme.primary becomes the accent color,
                          // colorScheme.error becomes the error color.
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // ── Resend row ────────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _secondsRemaining > 0
                                ? '${S.of(context).resendCodeIn} $_secondsRemaining${S.of(context).secondsSuffix}'
                                : '',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          InkWell(
                            onTap: _secondsRemaining == 0 && !_isVerifying
                                ? _onResend
                                : null,
                            borderRadius: BorderRadius.circular(4.r),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 2.h,
                              ),
                              child: Text(
                                S.of(context).resendCode,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: _secondsRemaining == 0 && !_isVerifying
                                      ? colorScheme.secondary
                                      : colorScheme.onSurfaceVariant.withValues(
                                          alpha: 0.6,
                                        ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Back link ────────────────────────────────────────────
                Center(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      S.of(context).useDifferentEmail,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
