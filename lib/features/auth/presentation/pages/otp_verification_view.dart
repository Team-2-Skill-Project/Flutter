import 'dart:async';

import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_state.dart';
import 'package:MatchIn/features/auth/presentation/widgets/otp_boxes_input.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key, this.email = 'user@example.com'});

  final String email;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  String _enteredOtp = '';
  int _secondsRemaining = 60;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

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

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _onVerify() {
    if (_enteredOtp.length == 6) {
      context.read<OtpCubit>().verifyOtp(email: widget.email, otp: _enteredOtp);
    }
  }

  void _onResend() {
    if (_secondsRemaining == 0) {
      context.read<OtpCubit>().resendOtp(email: widget.email);
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          context.push(AppRoutes.kCreateNewPasswordView, extra: widget.email);
        } else if (state is OtpVerificationError) {
          CustomSnackBar.showError(context, message: state.message);
        } else if (state is OtpResendSuccess) {
          CustomSnackBar.showSuccess(
            context,
            message: S.of(context).resendCode,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is OtpLoading;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(title: S.of(context).enterVerificationCode),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo / Icon section
                  Center(
                    child: Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
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
                        color: Colors.white,
                        size: 28.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Heading & Subtitle
                  Text(
                    S.of(context).enterVerificationCode,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.6,
                      height: 32 / 24,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    S.of(context).sentCodeToEmail,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 20 / 14,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Main Verification Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Label
                        Text(
                          S.of(context).verificationCodeLabel,
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.55,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // 6 Separate OTP Slots
                        OtpBoxesInput(
                          length: 6,
                          onChanged: (val) {
                            setState(() => _enteredOtp = val);
                          },
                          onCompleted: (val) {
                            setState(() => _enteredOtp = val);
                            _onVerify();
                          },
                        ),
                        SizedBox(height: 12.h),

                        // Helper Row under OTP Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _secondsRemaining > 0
                                  ? '${S.of(context).resendCodeIn} $_secondsRemaining${S.of(context).secondsSuffix}'
                                  : '',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            InkWell(
                              onTap: _secondsRemaining == 0 ? _onResend : null,
                              child: Text(
                                S.of(context).resendCode,
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _secondsRemaining == 0
                                      ? AppColors.secondary
                                      : AppColors.textSecondary.withValues(
                                          alpha: 0.6,
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

                  // Action Button
                  CustomButton(
                    text: S.of(context).verify,
                    onPressed: _onVerify,
                    isLoading: isLoading,
                    isEnabled: _enteredOtp.length == 6,
                  ),
                  SizedBox(height: 12.h),

                  // Secondary Link: Use a different email
                  Center(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        S.of(context).useDifferentEmail,
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
