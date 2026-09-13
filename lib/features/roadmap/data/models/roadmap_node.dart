enum RoadmapNodeStatus { completed, current, available, locked, milestone }

class RoadmapNode {
  const RoadmapNode({
    required this.title,
    this.subtitle,
    required this.status,
    this.duration,
    this.xp,
  });
  final String title;
  final String? subtitle;
  final RoadmapNodeStatus status;
  final String? duration;
  final int? xp;
}
