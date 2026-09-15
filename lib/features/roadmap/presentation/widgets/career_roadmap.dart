import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_view_body.dart';
import 'package:flutter/material.dart';

class CareerRoadmap extends StatelessWidget {
  const CareerRoadmap({super.key, required this.nodes});

  final List<RoadmapNode> nodes;

  @override
  Widget build(BuildContext context) {
    return RoadmapViewBody(nodes: nodes);
  }
}
