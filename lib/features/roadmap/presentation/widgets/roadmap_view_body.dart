import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_list_widget.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_xp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapViewBody extends StatelessWidget {
  const RoadmapViewBody({super.key, this.nodes});

  final List<RoadmapNode>? nodes;

  @override
  Widget build(BuildContext context) {
    if (nodes != null && nodes!.isNotEmpty) {
      return RoadmapContentWidget(nodes: nodes!);
    }

    return BlocBuilder<RoadmapCubit, RoadmapState>(
      builder: (context, state) {
        if (state is RoadmapLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is RoadmapSuccess) {
          return RoadmapContentWidget(
            nodes: state.nodes,
            collectedTreasures: state.collectedTreasures,
          );
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
}

class RoadmapContentWidget extends StatelessWidget {
  const RoadmapContentWidget({
    super.key,
    required this.nodes,
    this.collectedTreasures = const {},
  });

  final List<RoadmapNode> nodes;
  final Set<int> collectedTreasures;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Independent XP Progress Bar
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
          child: RoadmapXpBar(
            nodes: nodes,
            collectedTreasures: collectedTreasures,
          ),
        ),

        // Winding Roadmap List with Path & Floating Lotties
        Expanded(
          child: RoadmapListWidget(
            nodes: nodes,
            collectedTreasures: collectedTreasures,
          ),
        ),
      ],
    );
  }
}
