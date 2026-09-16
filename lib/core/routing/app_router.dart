import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/widgets/main_navigation_screen.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:MatchIn/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:MatchIn/features/auth/presentation/pages/create_new_password_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/otp_verification_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/password_changed_success_view.dart';
import 'package:MatchIn/features/jobs/presentation/views/jobs_search_view.dart';
import 'package:MatchIn/features/jobs/presentation/views/notifications_view.dart';
import 'package:MatchIn/features/jobs/presentation/views/settings_view.dart';
import 'package:MatchIn/features/onbording/presentation/pages/onbording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  AppRouter._();

  static CustomTransitionPage<dynamic>
  _buildTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.kHomeView,
    routes: [
      // Main Navigation
      GoRoute(
        path: AppRoutes.kHomeView,
        builder: (context, state) {
          return const MainNavigationScreen();
        },
      ),

      // Onboarding
      GoRoute(
        path: AppRoutes.kOnboardingView,
        builder: (context, state) {
          return const Onb1();
        },
      ),

      // Jobs
      GoRoute(
        path: AppRoutes.jobsSearch,
        builder: (context, state) {
          return const JobsSearchView();
        },
      ),

      // Authentication
      GoRoute(
        path: AppRoutes.kOtpVerificationView,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<OtpCubit>(),
            child: OtpVerificationView(
              email:
                  state.extra as String? ??
                  'user@example.com',
            ),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.kCreateNewPasswordView,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<ResetPasswordCubit>(),
            child: CreateNewPasswordView(
              email:
                  state.extra as String? ??
                  'user@example.com',
            ),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.kPasswordChangedSuccessView,
        builder: (context, state) {
          return const PasswordChangedSuccessView();
        },
      ),

      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) {
          return const NotificationsView();
        },
      ),

      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) {
          return const SettingsView();
        },
      ),

      // TODO: Add Job Details route.

      // TODO: Add application routes.
    ],
  );
}
