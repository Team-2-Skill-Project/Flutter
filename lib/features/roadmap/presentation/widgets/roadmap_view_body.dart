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
        // Dynamic horizontal offset from center for alternating zigzag
        final offsetAmount = (screenWidth * 0.22).clamp(50.0.w, 110.0.w);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 16.w),
            child: Column(
              children: List.generate(roadmapNodes.length, (index) {
                final node = roadmapNodes[index];
                final isLeft = index.isEven;
                final horizontalShift = isLeft ? -offsetAmount : offsetAmount;

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
