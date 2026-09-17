import 'package:MatchIn/core/widgets/app_web_view.dart';
import 'package:MatchIn/core/widgets/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:MatchIn/core/routing/app_routes.dart';

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
    routes: [
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: AppRoutes.kWebView,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>? ?? {};
          final url = args['url'] as String? ?? '';
          final title = args['title'] as String?;
          return AppWebView(
            url: url,
            title: title,
          );
        },
      ),
    ],
  );
}
