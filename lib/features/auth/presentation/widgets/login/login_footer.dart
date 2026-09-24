import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/widgets/social_login_button.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/views/or_divider.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginFooterInner extends StatelessWidget {
  const LoginFooterInner({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);

    return Column(
      children: [
        const OrDivider(),
        SizedBox(height: 12.h),
        SocialLoginButton(
          text: locale.registerWithGoogle,
          icon: const Icon(Icons.g_mobiledata, size: 28),
          onPressed: () {},
        ),
      ],
    );
  }
}

class LoginFooterOuter extends StatelessWidget {
  const LoginFooterOuter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = S.of(context);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(
                Icons.verified_user_outlined,
                color: AppColors.midnightBlue,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  locale.secureProtectionText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              locale.newHere,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            InkWell(
              onTap: () => context.go(AppRoutes.kRegisterView),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Text(
                  locale.createAccount,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.terracotta,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
