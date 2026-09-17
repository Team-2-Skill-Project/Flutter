import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:MatchIn/core/utils/app_text_styles.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:MatchIn/core/widgets/social_login_button.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isKeepSignedIn = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final theme = Theme.of(context);
    final locale = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.login,
          style: AppTextStyles.heading18Bold(isArabic: isArabic),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: _formKey,
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
                  controller: _emailController,
                  labelText: locale.email,
                  hintText: locale.emailHint,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Error'; 
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                
                CustomTextField(
                  controller: _passwordController,
                  labelText: locale.password,
                  hintText: locale.passwordHint,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Error';
                    }
                    return null;
                  },
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
                      onPressed: () {},
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
                    if (_formKey.currentState!.validate()) {
                      
                    }
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
                  icon: const Icon(Icons.g_mobiledata, size: 32), 
                  onPressed: () {},
                ),
                SizedBox(height: 32.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      locale.newHere,
                      style: AppTextStyles.body14SemiBold(isArabic: isArabic),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Text(
                          locale.createAccount,
                          style: AppTextStyles.body14Bold(
                            isArabic: isArabic,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}