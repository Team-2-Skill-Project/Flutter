import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_assets.dart';
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

  // Layout ratio & boundary constants replacing raw magic numbers
  static const double _minSpaceRatio = 0.35;
  static const double _lottieSizeRatio = 0.18;
  static const double _minLottieSize = 65.0;
  static const double _maxLottieSize = 88.0;
  static const double _taskHalfWidth = 70.0;
  static const double _horizontalMargin = 12.0;

  // Single scale factor for lottie decorations
  static const double _scaleFactor = 2.0;

  // Centralized asset constants
  static const List<String> _lottieAssets = [
    Assets.lottieGraduationHat,
    Assets.lottieBooks1Lottie,
    Assets.lottieBooks2Lottie,
  ];

  @override
  Widget build(BuildContext context) {
    if (!_shouldShowDecoration()) {
      return const SizedBox.shrink();
    }

    final assetPath = _getAsset();
    final lottieSize = _calculateLottieSize();
    final lottieLeft = _calculateLottieLeft(lottieSize);

    return Positioned(
      left: lottieLeft,
      child: IgnorePointer(
        child: FloatingLottieWidget(
          assetPath: assetPath,
          size: lottieSize,
          scaleFactor: _scaleFactor,
        ),
      ),
    );
  }

  bool _shouldShowDecoration() {
    final minSpaceThreshold = maxOffset * _minSpaceRatio;
    if (horizontalShift.abs() < minSpaceThreshold) {
      return false;
    }
    return index % 2 == 1 || index % 5 == 0;
  }

  String _getAsset() {
    return _lottieAssets[(index ~/ 2) % _lottieAssets.length];
  }

  double _calculateLottieSize() {
    return (screenWidth * _lottieSizeRatio).clamp(
      _minLottieSize.r,
      _maxLottieSize.r,
    );
  }

  double _calculateLottieLeft(double lottieSize) {
    final screenCenter = screenWidth / 2;
    final taskCenterX = screenCenter + horizontalShift;
    final scaledTaskHalfWidth = _taskHalfWidth.w;

    double lottieLeft;

    if (horizontalShift > 0) {
      final taskLeftEdge = (taskCenterX - scaledTaskHalfWidth).clamp(
        0.0,
        screenWidth,
      );
      final emptySpaceCenter = taskLeftEdge / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    } else {
      final taskRightEdge = (taskCenterX + scaledTaskHalfWidth).clamp(
        0.0,
        screenWidth,
      );
      final emptySpaceCenter = (taskRightEdge + screenWidth) / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    }

    final minMargin = _horizontalMargin.w;
    final maxMargin = screenWidth - lottieSize - minMargin;
    return lottieLeft.clamp(minMargin, maxMargin);
  }
}
