import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_emailController.text.trim().isEmpty) {
        CustomSnackBar.showError(context, message: 'Please enter your email');
        return;
      }
      context.push(
        AppRoutes.kOtpVerificationView,
        extra: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Create Account'),
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
                      Icons.person_add_outlined,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Heading & Subtitle
                Text(
                  'Create Account',
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
                  'Join MatchIn to explore personalized career opportunities',
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
                        controller: _nameController,
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                      ),
                      SizedBox(height: 16.h),
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

                // Register Action Button
                CustomButton(text: 'Create Account', onPressed: _onRegister),
                SizedBox(height: 16.h),

                // Already have an account -> Login Link
                Center(
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.kLoginView),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).backToLogin,
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
