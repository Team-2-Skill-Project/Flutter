import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:MatchIn/core/utils/app_text_styles.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/social_login_button.dart';
import 'package:MatchIn/generated/l10n.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isKeepSignedIn = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final theme = Theme.of(context);
    final locale = S.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          locale.login,
          style: AppTextStyles.heading18Bold(isArabic: isArabic),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.imagesTextLogo, height: 40.h),
              SizedBox(height: 16.h),
              Text(
                locale.welcomeBack,
                style: AppTextStyles.heading24Bold(isArabic: isArabic),
              ),
              SizedBox(height: 8.h),
              Text(
                locale.smartCareerDiscoveryPlatform,
                style: AppTextStyles.body14Regular(
                  isArabic: isArabic,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 32.h),

              CustomTextField(
                labelText: locale.email,
                hintText: locale.emailHint,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              
              CustomTextField(
                labelText: locale.password,
                hintText: locale.passwordHint,
                isPassword: true,
              ),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Switch(
                        value: isKeepSignedIn,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            isKeepSignedIn = value;
                          });
                        },
                      ),
                      Text(
                        locale.keepMeSignedIn,
                        style: AppTextStyles.body12Regular(isArabic: isArabic),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to Forgot Password
                    },
                    child: Text(
                      locale.forgotPassword,
                      style: AppTextStyles.body12SemiBold(
                        isArabic: isArabic,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              CustomButton(
                text: locale.login,
                onPressed: () {
                  // TODO: trigger login event
                },
              ),
              SizedBox(height: 16.h),
              
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      locale.or, 
                      style: AppTextStyles.body14Regular(isArabic: isArabic)
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 16.h),
              
              SocialLoginButton(
                text: locale.registerWithGoogle,
                onPressed: () {
                  // TODO: trigger google login event
                },
              ),
              SizedBox(height: 32.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locale.newHere,
                    style: AppTextStyles.body14SemiBold(isArabic: isArabic),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to Register
                    },
                    child: Text(
                      locale.createAccount,
                      style: AppTextStyles.body14Bold(
                        isArabic: isArabic,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}