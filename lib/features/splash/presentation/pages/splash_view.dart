import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/features/splash/presentation/widgets/animated_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() async {
    // زودنا الوقت ل 4 ثواني عشان الانيميشن ياخد وقته
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;

    context.go(AppRoutes.kOnboardingView);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFAF8F4),
      body: AnimatedLogoWidget(),
    );
  }
}
