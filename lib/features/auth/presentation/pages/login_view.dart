import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:MatchIn/core/widgets/social_login_button.dart';
import 'package:MatchIn/features/auth/presentation/pages/register_view.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  // wait cubit
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _isKeepSignedIn = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.login,
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
              SizedBox(height: 16.h),
              Center(
                child: Text(
                  locale.welcomeBack,
                  style: theme.textTheme.headlineSmall,
                ),
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
                      ValueListenableBuilder<bool>(
                        valueListenable: _isKeepSignedIn,
                        builder: (context, value, child) {
                          return Switch(
                            value: value,
                            activeColor: theme.colorScheme.primary,
                            onChanged: (newValue) {
                              _isKeepSignedIn.value = newValue;
                            },
                          );
                        },
                      ),
                      Text(
                        locale.keepMeSignedIn,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      locale.forgotPassword,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                    // الاكشن هيتحط هنا بعدين
                  }
                },
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(locale.or, style: theme.textTheme.bodyMedium),
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
                  Text(locale.newHere, style: theme.textTheme.bodyMedium),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  RegisterView(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Text(
                        locale.createAccount,
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