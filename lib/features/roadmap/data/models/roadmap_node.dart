enum RoadmapTaskStatus {
  completed,
  active,
  locked,
}

typedef RoadmapNodeStatus = RoadmapTaskStatus;

class RoadmapNode {
  const RoadmapNode({
    required this.title,
    this.subtitle,
    required this.status,
    this.duration,
    this.xp,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final RoadmapTaskStatus status;
  final String? duration;
  final int? xp;
  final dynamic icon;
}
