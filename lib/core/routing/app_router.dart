import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/widgets/main_navigation_screen.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:MatchIn/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:MatchIn/features/auth/presentation/pages/create_new_password_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/otp_verification_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/password_changed_success_view.dart';
import 'package:MatchIn/features/onbording/presentation/pages/onbording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  //* --- Global Transition ---

  // ignore: unused_element
  static CustomTransitionPage<dynamic> _buildTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static final router = GoRouter(
    initialLocation: AppRoutes.kOnboardingView,
    routes: [
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: AppRoutes.kOnboardingView,
        builder: (context, state) => const Onb1(),
      ),
      GoRoute(
        path: AppRoutes.kOtpVerificationView,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<OtpCubit>(),
          child: OtpVerificationView(
            email: state.extra as String? ?? 'user@example.com',
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.kCreateNewPasswordView,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ResetPasswordCubit>(),
          child: CreateNewPasswordView(
            email: state.extra as String? ?? 'user@example.com',
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.kPasswordChangedSuccessView,
        builder: (context, state) => const PasswordChangedSuccessView(),
      ),
    ],
  );
}
