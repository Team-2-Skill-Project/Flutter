import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/floating_lottie_widget.dart';

/// Renders decorative Lottie animations centered in negative horizontal space along the roadmap.
class RoadmapLottieDecoration extends StatelessWidget {
  const RoadmapLottieDecoration({
    super.key,
    required this.index,
    required this.horizontalShift,
    required this.maxOffset,
    required this.screenWidth,
  });

  final int index;
  final double horizontalShift;
  final double maxOffset;
  final double screenWidth;

  static const List<String> lottieAssets = [
    'assets/lottie/graduation_hat.json',
    'assets/lottie/books_1.lottie.json',
    'assets/lottie/books_2.lottie.json',
  ];

  static const Map<String, double> assetScaleFactors = {
    'assets/lottie/graduation_hat.json': 2.0,
    'assets/lottie/books_1.lottie.json': 2.0,
    'assets/lottie/books_2.lottie.json': 2.0,
  };

  @override
  Widget build(BuildContext context) {
    final minSpaceThreshold = maxOffset * 0.35;
    if (horizontalShift.abs() < minSpaceThreshold) {
      return const SizedBox.shrink();
    }

    if (index % 2 != 1 && index % 5 != 0) {
      return const SizedBox.shrink();
    }

    final assetPath = lottieAssets[(index ~/ 2) % lottieAssets.length];
    final scaleFactor = assetScaleFactors[assetPath] ?? 1.0;
    final lottieSize = (screenWidth * 0.18).clamp(65.0.r, 88.0.r);

    final screenCenter = screenWidth / 2;
    final taskCenterX = screenCenter + horizontalShift;
    final taskHalfWidth = 70.0.w;

    double lottieLeft;

    if (horizontalShift > 0) {
      final taskLeftEdge = (taskCenterX - taskHalfWidth).clamp(
        0.0,
        screenWidth,
      );
      final emptySpaceCenter = taskLeftEdge / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    } else {
      final taskRightEdge = (taskCenterX + taskHalfWidth).clamp(
        0.0,
        screenWidth,
      );
      final emptySpaceCenter = (taskRightEdge + screenWidth) / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    }

    final minMargin = 12.w;
    final maxMargin = screenWidth - lottieSize - 12.w;
    lottieLeft = lottieLeft.clamp(minMargin, maxMargin);

    return Positioned(
      left: lottieLeft,
      child: IgnorePointer(
        child: FloatingLottieWidget(
          assetPath: assetPath,
          size: lottieSize,
          scaleFactor: scaleFactor,
        ),
      ),
    );
  }
}
