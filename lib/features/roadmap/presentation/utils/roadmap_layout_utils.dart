import 'dart:math';

/// Utility functions for roadmap layout calculations.
abstract final class RoadmapLayoutUtils {
  RoadmapLayoutUtils._();

  /// Calculates a smooth, organic horizontal offset for each item along the winding curve.
  static double calculateOrganicOffset(int index, double maxOffset) {
    final t = index.toDouble();
    final rawOffset = 0.65 * sin(t * 0.85) + 0.35 * sin(t * 0.45 + 0.8);
    final clamped = rawOffset.clamp(-1.0, 1.0);
    return clamped * maxOffset;
  }
}
