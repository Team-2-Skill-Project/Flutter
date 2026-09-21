import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    if (getIt.isRegistered<SharedPreferencesService>()) {
      final prefs = getIt<SharedPreferencesService>();
      final isOnboarded = prefs.isOnBoardingViewed();
      final isLoggedIn = prefs.isLoggedIn();

      if (!isOnboarded) {
        context.go(AppRoutes.kOnboardingView);
      } else if (isLoggedIn) {
        context.go(AppRoutes.kHomeView);
      } else {
        context.go(AppRoutes.kLoginView);
      }
    } else {
      context.go(AppRoutes.kLoginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Image.asset(
          'assets/images/app_icon.png',
          width: 150.w,
          height: 150.h,
        ),
      ),
    );
  }
}
