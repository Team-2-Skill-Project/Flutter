import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:MatchIn/core/widgets/social_login_button.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // استخدمنا ValueNotifier عشان ال Checkbox
  final ValueNotifier<bool> _isTermsAccepted = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
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
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            children: [
              Center(
                child: SvgPicture.asset(Assets.imagesTextLogo, height: 40.h),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  locale.smartCareerDiscoveryPlatform,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
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
                  ValueListenableBuilder<bool>(
                    valueListenable: _isTermsAccepted,
                    builder: (context, value, child) {
                      return Checkbox(
                        value: value,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (newValue) {
                          _isTermsAccepted.value = newValue ?? false;
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      locale.termsAndConditions,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              CustomButton(
                text: locale.completeRegistration,
                onPressed: () {
                  // ضفنا شرط ان اليوزر يكون موافق علي الشروط عشان يكمل
                  if (_formKey.currentState!.validate() && _isTermsAccepted.value) {
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
                      style: theme.textTheme.bodyMedium,
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
                    style: theme.textTheme.bodyMedium,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Text(
                        locale.login,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
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
    );
  }
}