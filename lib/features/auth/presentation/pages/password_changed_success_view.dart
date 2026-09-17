import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PasswordChangedSuccessView extends StatelessWidget {
  const PasswordChangedSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Soft Circular Success Container
              Container(
                width: 88.w,
                height: 88.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF3ED),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.success.withValues(
                      alpha: 0.2,
                    ),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_rounded,
                  size: 38.sp,
                  color: AppColors.success,
                ),
              ),
              SizedBox(height: 24.h),

              // Headline
              Text(
                S.of(context).passwordChangedSuccessfully,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.6,
                  height: 32 / 24,
                ),
              ),
              SizedBox(height: 12.h),

              // Supporting Text
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Text(
                  S.of(context).passwordChangedSuccessDesc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 23 / 14,
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // Primary Action
              CustomButton(
                text: S.of(context).backToLogin,
                onPressed: () =>
                    context.go(AppRoutes.kLoginView),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
