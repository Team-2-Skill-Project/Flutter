import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';
import 'package:MatchIn/features/auth/presentation/widgets/login_form_card.dart';
import 'package:MatchIn/features/auth/presentation/widgets/login_header.dart';
import 'package:MatchIn/features/auth/presentation/widgets/login_register_link.dart';
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
                const LoginHeader(),
                SizedBox(height: 24.h),
                LoginFormCard(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                SizedBox(height: 24.h),
                CustomButton(text: 'Sign In', onPressed: _onLogin),
                SizedBox(height: 16.h),
                LoginRegisterLink(
                  onPressed: () => context.go(AppRoutes.kRegisterView),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
