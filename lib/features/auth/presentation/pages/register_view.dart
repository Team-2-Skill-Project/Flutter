import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';
import 'package:MatchIn/features/auth/presentation/widgets/register_form_card.dart';
import 'package:MatchIn/features/auth/presentation/widgets/register_header.dart';
import 'package:MatchIn/features/auth/presentation/widgets/register_login_link.dart';
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
                const RegisterHeader(),
                SizedBox(height: 24.h),
                RegisterFormCard(
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                SizedBox(height: 24.h),
                CustomButton(text: 'Create Account', onPressed: _onRegister),
                SizedBox(height: 16.h),
                RegisterLoginLink(
                  onPressed: () => context.go(AppRoutes.kLoginView),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
