import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:MatchIn/core/utils/app_text_styles.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:MatchIn/core/widgets/social_login_button.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isTermsAccepted = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final theme = Theme.of(context);
    final locale = S.of(context); 

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          locale.createAccount, 
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
                ),
                SizedBox(height: 16.h),
                
                CustomTextField(
                  controller: _phoneController,
                  labelText: locale.phoneNumber,
                  hintText: locale.phoneHint,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.h),
                
                CustomTextField(
                  controller: _passwordController,
                  labelText: locale.password,
                  hintText: locale.passwordHint,
                  isPassword: true,
                ),
                SizedBox(height: 16.h),
                
                CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: locale.confirmPassword,
                  hintText: locale.confirmPasswordHint,
                  isPassword: true,
                ),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Checkbox(
                      value: isTermsAccepted,
                      activeColor: theme.colorScheme.primary,
                      onChanged: (value) {
                        setState(() {
                          isTermsAccepted = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        locale.termsAndConditions,
                        style: AppTextStyles.body12Regular(isArabic: isArabic),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                CustomButton(
                  text: locale.completeRegistration,
                  onPressed: () {
                    if (_formKey.currentState!.validate() && isTermsAccepted) {
                      // TODO: trigger register event
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
                      locale.alreadyHaveAccount,
                      style: AppTextStyles.body14SemiBold(isArabic: isArabic),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Text(
                          locale.login,
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