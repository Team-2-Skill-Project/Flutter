import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _splashViewState();
}

class _splashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F4),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          builder: (context, double opacity, child) {
            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: 0.8 + (opacity * 0.2),
                child: child,
              ),
            );
          },
          child: Image.asset(
            'assets/images/app_icon.jpg',
            width: 180,
          ),
        ),
      ),
    );
  }
}
