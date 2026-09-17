import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/core/widgets/app_web_view.dart';
import 'package:MatchIn/core/widgets/main_navigation_screen.dart';
import 'package:MatchIn/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:MatchIn/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:MatchIn/features/auth/presentation/pages/create_new_password_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/login_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/otp_verification_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/password_changed_success_view.dart';
import 'package:MatchIn/features/auth/presentation/pages/register_view.dart';
import 'package:MatchIn/features/jobs/presentation/views/jobs_search_view.dart';
import 'package:MatchIn/features/onbording/presentation/pages/onbording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  AppRouter._();

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

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.kOnboardingView,
    redirect: (context, state) {
      if (!getIt.isRegistered<SharedPreferencesService>()) return null;
      final prefs = getIt<SharedPreferencesService>();
      final isOnboarded = prefs.isOnBoardingViewed();
      final isLoggedIn = prefs.isLoggedIn();

      final location = state.uri.path;

      if (location == AppRoutes.kSplashView ||
          location == AppRoutes.kOnboardingView) {
        if (!isOnboarded) {
          return AppRoutes.kOnboardingView;
        }
        if (isLoggedIn) {
          return AppRoutes.kHomeView;
        }
        return AppRoutes.kRegisterView;
      }

      return null;
    },
    routes: [
      // Splash / Root
      GoRoute(
        path: AppRoutes.kSplashView,
        pageBuilder: (context, state) =>
            _buildTransitionPage(state: state, child: const Onb1()),
      ),

      // Onboarding
      GoRoute(
        path: AppRoutes.kOnboardingView,
        pageBuilder: (context, state) =>
            _buildTransitionPage(state: state, child: const Onb1()),
      ),

      // Main Navigation
      GoRoute(
        path: AppRoutes.kHomeView,
        pageBuilder: (context, state) => _buildTransitionPage(
          state: state,
          child: const MainNavigationScreen(),
        ),
      ),

      // Reusable WebView
      GoRoute(
        path: AppRoutes.kWebView,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>? ?? {};
          final url = args['url'] as String? ?? '';
          final title = args['title'] as String?;
          return _buildTransitionPage(
            state: state,
            child: AppWebView(url: url, title: title),
          );
        },
      ),

      // Jobs
      GoRoute(
        path: AppRoutes.kJobsSearchView,
        pageBuilder: (context, state) =>
            _buildTransitionPage(state: state, child: const JobsSearchView()),
      ),

      // Authentication Routes
      GoRoute(
        path: AppRoutes.kRegisterView,
        pageBuilder: (context, state) =>
            _buildTransitionPage(state: state, child: const RegisterView()),
      ),

      GoRoute(
        path: AppRoutes.kLoginView,
        pageBuilder: (context, state) =>
            _buildTransitionPage(state: state, child: const LoginView()),
      ),

      GoRoute(
        path: AppRoutes.kForgetPasswordView,
        pageBuilder: (context, state) => _buildTransitionPage(
          state: state,
          child: BlocProvider(
            create: (_) => getIt<OtpCubit>(),
            child: OtpVerificationView(
              email: state.extra as String? ?? 'user@example.com',
            ),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutes.kOtpVerificationView,
        pageBuilder: (context, state) => _buildTransitionPage(
          state: state,
          child: BlocProvider(
            create: (_) => getIt<OtpCubit>(),
            child: OtpVerificationView(
              email: state.extra as String? ?? 'user@example.com',
            ),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutes.kCreateNewPasswordView,
        pageBuilder: (context, state) => _buildTransitionPage(
          state: state,
          child: BlocProvider(
            create: (_) => getIt<ResetPasswordCubit>(),
            child: CreateNewPasswordView(
              email: state.extra as String? ?? 'user@example.com',
            ),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutes.kPasswordChangedSuccessView,
        pageBuilder: (context, state) => _buildTransitionPage(
          state: state,
          child: const PasswordChangedSuccessView(),
        ),
      ),
    ],
  );
}
