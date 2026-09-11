// ignore_for_file: unused_import
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
      //TODO: add routes
    ],
  );
}
