import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/widgets/social_login_button.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = S.of(context);

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                locale.or,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.border)),
          ],
        ),
        SizedBox(height: 12.h),
        SocialLoginButton(
          text: locale.registerWithGoogle,
          icon: const Icon(Icons.g_mobiledata, size: 24),
          onPressed: () {},
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              locale.alreadyHaveAccount,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.terracotta,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () => context.go(AppRoutes.kLoginView),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Text(
                  locale.login,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.terracotta,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),

        // SizedBox(height: 4.h),
        // Text(
        //   locale.uploadCvOptional,
        //   style: theme.textTheme.bodySmall?.copyWith(
        //     color: AppColors.textSecondary,
        //   ),
        // ),
      ],
    );
  }
}
