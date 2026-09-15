import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:flutter/material.dart';

final roadmapNodes = [
  const RoadmapNode(
    title: 'Dart Fundamentals',
    subtitle: 'Foundation',
    status: RoadmapTaskStatus.completed,
    icon: Icons.code_rounded,
  ),

  const RoadmapNode(
    title: 'OOP & Clean Code',
    subtitle: 'Foundation',
    status: RoadmapTaskStatus.completed,
    icon: Icons.architecture_rounded,
  ),

  const RoadmapNode(
    title: 'Flutter Fundamentals',
    subtitle: 'Core Flutter',
    status: RoadmapTaskStatus.active,
    duration: '~2 hours',
    xp: 250,
    icon: Icons.flutter_dash_rounded,
  ),

  const RoadmapNode(
    title: 'State Management',
    subtitle: 'Engineering',
    status: RoadmapTaskStatus.locked,
    duration: '~3 hours',
    xp: 300,
    icon: Icons.layers_rounded,
  ),

  const RoadmapNode(
    title: 'REST APIs',
    subtitle: 'Engineering',
    status: RoadmapTaskStatus.locked,
    duration: '~2 hours',
    xp: 250,
    icon: Icons.cloud_sync_rounded,
  ),

  const RoadmapNode(
    title: 'Clean Architecture',
    subtitle: 'Architecture',
    status: RoadmapTaskStatus.locked,
    duration: '~4 hours',
    xp: 400,
    icon: Icons.account_tree_rounded,
  ),

  const RoadmapNode(
    title: 'Testing & CI/CD',
    subtitle: 'Quality',
    status: RoadmapTaskStatus.locked,
    duration: '~3 hours',
    xp: 300,
    icon: Icons.verified_user_rounded,
  ),

  const RoadmapNode(
    title: 'Real World Project',
    subtitle: 'Job Ready',
    status: RoadmapTaskStatus.locked,
    duration: '~8 hours',
    xp: 700,
    icon: Icons.stars_rounded,
  ),
];
