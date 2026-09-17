import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_emailController.text.trim().isEmpty) {
        CustomSnackBar.showError(context, message: 'Please enter your email');
        return;
      }

      await getIt<SharedPreferencesService>().setLoggedIn(true);

      if (mounted) {
        context.go(AppRoutes.kHomeView);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Sign In'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Icon Container
                Center(
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Heading & Subtitle
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.6,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Sign in to continue your career journey',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),

                // Main Form Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        labelText: 'Email Address',
                        hintText: 'user@example.com',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        hintText: '••••••••',
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Login Action Button
                CustomButton(text: 'Sign In', onPressed: _onLogin),
                SizedBox(height: 16.h),

                // Link to Register Page
                Center(
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.kRegisterView),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Create Account',
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
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
