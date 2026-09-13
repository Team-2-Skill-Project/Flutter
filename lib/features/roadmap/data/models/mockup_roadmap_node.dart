import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';

final roadmapNodes = [
  const RoadmapNode(
    title: 'Dart Fundamentals',
    subtitle: 'Foundation',
    status: RoadmapNodeStatus.completed,
  ),

  const RoadmapNode(
    title: 'OOP & Clean Code',
    subtitle: 'Foundation',
    status: RoadmapNodeStatus.completed,
  ),

  const RoadmapNode(
    title: 'Flutter Fundamentals',
    subtitle: 'Core Flutter',
    status: RoadmapNodeStatus.current,
    duration: '~2 hours',
    xp: 250,
  ),

  const RoadmapNode(
    title: 'State Management',
    subtitle: 'Engineering',
    status: RoadmapNodeStatus.locked,
    duration: '~3 hours',
    xp: 300,
  ),

  const RoadmapNode(
    title: 'REST APIs',
    subtitle: 'Engineering',
    status: RoadmapNodeStatus.locked,
    duration: '~2 hours',
    xp: 250,
  ),

  const RoadmapNode(
    title: 'Clean Architecture',
    subtitle: 'Architecture',
    status: RoadmapNodeStatus.locked,
    duration: '~4 hours',
    xp: 400,
  ),

  const RoadmapNode(
    title: 'Engineering Ready',
    status: RoadmapNodeStatus.milestone,
  ),

  const RoadmapNode(
    title: 'Testing',
    subtitle: 'Architecture',
    status: RoadmapNodeStatus.locked,
    duration: '~3 hours',
    xp: 300,
  ),

  const RoadmapNode(
    title: 'Real World Project',
    subtitle: 'Job Ready',
    status: RoadmapNodeStatus.locked,
    duration: '~8 hours',
    xp: 700,
  ),

  const RoadmapNode(title: 'Job Ready', status: RoadmapNodeStatus.milestone),
];
