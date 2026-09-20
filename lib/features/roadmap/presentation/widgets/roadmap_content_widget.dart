import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_list_widget.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_xp_bar.dart';

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
