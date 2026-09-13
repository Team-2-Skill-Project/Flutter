import 'package:MatchIn/features/roadmap/data/models/mockup_roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/career_roadmap.dart';
import 'package:flutter/material.dart';

class RoadmapView extends StatelessWidget {
  const RoadmapView({super.key});

  @override
  Widget build(BuildContext context) {
    return CareerRoadmap(nodes: roadmapNodes);
  }
}
