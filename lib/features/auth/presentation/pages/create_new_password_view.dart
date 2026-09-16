import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:MatchIn/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:MatchIn/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:MatchIn/features/auth/presentation/widgets/password_requirement_tile.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({
    super.key,
    this.email = 'user@example.com',
  });

  final String email;

  @override
  State<CreateNewPasswordView> createState() =>
      _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState
    extends State<CreateNewPasswordView> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(
      () => setState(() {}),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMinLength =>
      _passwordController.text.length >= 8;
  bool get _hasNumber =>
      RegExp(r'[0-9]').hasMatch(_passwordController.text);
  bool get _hasSpecialChar =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>]')
          .hasMatch(_passwordController.text);
  bool get _isPasswordMatching =>
      _passwordController.text.isNotEmpty &&
      _passwordController.text ==
          _confirmPasswordController.text;

  bool get _isValid =>
      _hasMinLength &&
      _hasNumber &&
      _hasSpecialChar &&
      _isPasswordMatching;

  void _onSubmit() {
    if (!_isValid) {
      if (!_isPasswordMatching) {
        CustomSnackBar.showError(
          context,
          message: S.of(context).passwordsDoNotMatch,
        );
      }
      return;
    }

    context.read<ResetPasswordCubit>().resetPassword(
      email: widget.email,
      newPassword: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      ResetPasswordCubit,
      ResetPasswordState
    >(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          context.go(AppRoutes.kPasswordChangedSuccessView);
        } else if (state is ResetPasswordError) {
          CustomSnackBar.showError(
            context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;

        return Scaffold(
          backgroundColor: Theme.of(context)
              .scaffoldBackgroundColor,
          appBar: CustomAppBar(
            title: S.of(context).createNewPassword,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Header Intro
                  Text(
                    S.of(context).createNewPassword,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                      letterSpacing: -0.6,
                      height: 32 / 24,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    S.of(context).chooseStrongPassword,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                      height: 20 / 14,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Form Card Container
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surface,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                      border: Border.all(
                        color: Theme.of(context)
                            .dividerColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // Field 1: New password
                        CustomTextField(
                          controller: _passwordController,
                          labelText: S
                              .of(context)
                              .newPassword,
                          hintText: '••••••••',
                          isPassword: true,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          S.of(context).passwordLengthHint,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Divider
                        Divider(
                          color: Theme.of(context)
                              .dividerColor,
                          thickness: 1,
                        ),
                        SizedBox(height: 12.h),

                        // Field 2: Confirm new password
                        CustomTextField(
                          controller:
                              _confirmPasswordController,
                          labelText: S
                              .of(context)
                              .confirmNewPassword,
                          hintText: '••••••••',
                          isPassword: true,
                        ),
                        SizedBox(height: 16.h),

                        // Password Requirements Subsection
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            top: 12.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context)
                                    .dividerColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .passwordRequirements,
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 14.sp,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              PasswordRequirementTile(
                                text: S
                                    .of(context)
                                    .reqMin8Chars,
                                isMet: _hasMinLength,
                              ),
                              PasswordRequirementTile(
                                text: S
                                    .of(context)
                                    .reqAtLeastOneNumber,
                                isMet: _hasNumber,
                              ),
                              PasswordRequirementTile(
                                text: S
                                    .of(context)
                                    .reqAtLeastOneSpecial,
                                isMet: _hasSpecialChar,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Action Stack
                  CustomButton(
                    text: S.of(context).resetPassword,
                    onPressed: _onSubmit,
                    isLoading: isLoading,
                    isEnabled: _isValid,
                  ),
                  SizedBox(height: 12.h),

                  // Link back to login
                  Center(
                    child: TextButton(
                      onPressed: () =>
                          context.go(AppRoutes.kLoginView),
                      child: Text(
                        S.of(context).backToLogin,
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
