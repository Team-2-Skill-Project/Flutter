import 'dart:math';

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

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Transform.translate(
                    offset: Offset(horizontalShift, 0),
                    child: Center(
                      child: RoadmapTaskNode(
                        node: node,
                        onTap: () => _onNodeTap(context, node),
                      ),
                    ),
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
