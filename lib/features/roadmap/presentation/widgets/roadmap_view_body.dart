import 'dart:math';

import 'package:MatchIn/core/functions/show_image.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapViewBody extends StatelessWidget {
  const RoadmapViewBody({super.key, this.nodes});

  final List<RoadmapNode>? nodes;

  /// Available Lottie animation assets for roadmap decoration
  static const List<String> _lottieAssets = [
    'assets/lottie/graduation_hat.json',
    'assets/lottie/books_1.lottie.json',
    'assets/lottie/books_2.lottie.json',
  ];

  @override
  Widget build(BuildContext context) {
    if (nodes != null && nodes!.isNotEmpty) {
      return _buildRoadmapList(context, nodes!);
    }

    return BlocBuilder<RoadmapCubit, RoadmapState>(
      builder: (context, state) {
        if (state is RoadmapLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is RoadmapSuccess) {
          return _buildRoadmapList(context, state.nodes);
        } else if (state is RoadmapFailure) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(color: AppColors.error, fontSize: 14.sp),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRoadmapList(BuildContext context, List<RoadmapNode> roadmapNodes) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        // Maximum horizontal offset from center for organic curve range
        final maxOffset = (screenWidth * 0.28).clamp(60.0.w, 120.0.w);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 16.w),
            child: Column(
              children: List.generate(roadmapNodes.length, (index) {
                final node = roadmapNodes[index];
                // Calculate organic horizontal offset using continuous dual-harmonic wave
                final horizontalShift = _calculateOrganicOffset(index, maxOffset);
                // Calculate Lottie decoration centered dynamically in available negative space
                final lottieWidget = _buildLottieDecoration(
                  index: index,
                  horizontalShift: horizontalShift,
                  maxOffset: maxOffset,
                  screenWidth: screenWidth,
                );

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Task Node positioned along the organic winding path
                      Transform.translate(
                        offset: Offset(horizontalShift, 0),
                        child: Center(
                          child: RoadmapTaskNode(
                            node: node,
                            onTap: () => _onNodeTap(context, node),
                          ),
                        ),
                      ),

                      // Decorative Lottie animation centered in empty horizontal negative space
                      ?lottieWidget,
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  /// Calculates a smooth, organic horizontal offset for each task node.
  /// Uses a dual-frequency harmonic wave function to create a natural, continuous S-curve progression.
  double _calculateOrganicOffset(int index, double maxOffset) {
    final t = index.toDouble();
    // Superposition of two sine frequencies creates a dynamic, organic winding path
    final rawOffset = 0.65 * sin(t * 0.85) + 0.35 * sin(t * 0.45 + 0.8);
    final clamped = rawOffset.clamp(-1.0, 1.0);
    return clamped * maxOffset;
  }

  /// Builds a decorative Lottie animation centered in the empty horizontal negative space
  /// beside the task node, vertically aligned with the node.
  Widget? _buildLottieDecoration({
    required int index,
    required double horizontalShift,
    required double maxOffset,
    required double screenWidth,
  }) {
    // Only place Lottie animation when there is sufficient empty negative space
    final minSpaceThreshold = maxOffset * 0.35;
    if (horizontalShift.abs() < minSpaceThreshold) {
      return null;
    }

    // Distribute Lotties across selected nodes to maintain clean aesthetic
    if (index % 2 != 1 && index % 5 != 0) {
      return null;
    }

    // Cycle through available Lottie assets
    final assetPath = _lottieAssets[(index ~/ 2) % _lottieAssets.length];

    // Responsive larger Lottie size (scaled between 72.r and 90.r)
    final lottieSize = (screenWidth * 0.22).clamp(72.0.r, 90.0.r);

    // Screen center and node container bounds
    final screenCenter = screenWidth / 2;
    final taskCenterX = screenCenter + horizontalShift;

    // Approximate width radius of task node + title label
    final taskHalfWidth = 70.0.w;

    double lottieLeft;

    if (horizontalShift > 0) {
      // Task is shifted RIGHT -> empty space is on the LEFT (from 0 to taskLeftEdge)
      final taskLeftEdge = (taskCenterX - taskHalfWidth).clamp(0.0, screenWidth);
      final emptySpaceCenter = taskLeftEdge / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    } else {
      // Task is shifted LEFT -> empty space is on the RIGHT (from taskRightEdge to screenWidth)
      final taskRightEdge = (taskCenterX + taskHalfWidth).clamp(0.0, screenWidth);
      final emptySpaceCenter = (taskRightEdge + screenWidth) / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    }

    // Clamp lottieLeft safely to avoid screen edge overflow
    final minMargin = 12.w;
    final maxMargin = screenWidth - lottieSize - 12.w;
    lottieLeft = lottieLeft.clamp(minMargin, maxMargin);

    return Positioned(
      left: lottieLeft,
      child: IgnorePointer(
        child: SizedBox(
          width: lottieSize,
          height: lottieSize,
          child: showImage(
            image: assetPath,
            fit: BoxFit.contain,
            width: lottieSize,
            height: lottieSize,
          ),
        ),
      ),
    );
  }

  void _onNodeTap(BuildContext context, RoadmapNode node) {
    if (node.status == RoadmapTaskStatus.locked) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Complete the previous task first to unlock!',
            style: TextStyle(fontSize: 14.sp),
          ),
          backgroundColor: AppColors.secondary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) {
        return SkillDetailsSheet(node: node);
      },
    );
  }
}
