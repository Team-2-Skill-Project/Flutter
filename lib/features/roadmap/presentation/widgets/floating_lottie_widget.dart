import 'package:MatchIn/core/functions/show_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Lightweight presentation widget adding a calm, subtle vertical floating animation
/// to the decorative Lottie container without interrupting internal Lottie playback.
class FloatingLottieWidget extends StatefulWidget {
  const FloatingLottieWidget({
    super.key,
    required this.assetPath,
    required this.size,
    required this.scaleFactor,
  });

  final String assetPath;
  final double size;
  final double scaleFactor;

  @override
  State<FloatingLottieWidget> createState() => _FloatingLottieWidgetState();
}

class _FloatingLottieWidgetState extends State<FloatingLottieWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -3.5.h,
      end: 3.5.h,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Transform.scale(
        scale: widget.scaleFactor,
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: showImage(
            image: widget.assetPath,
            fit: BoxFit.contain,
            width: widget.size,
            height: widget.size,
          ),
        ),
      ),
    );
  }
}
