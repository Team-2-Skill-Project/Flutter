import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';

/// Data representation of an item along the winding roadmap path (Node vs Treasure).
class RoadmapItem {
  RoadmapItem.node(this.node, this.taskIndex)
    : milestoneIndex = null,
      targetNodeIndex = null;

  RoadmapItem.treasure(this.milestoneIndex, this.targetNodeIndex)
    : node = null,
      taskIndex = null;

  final RoadmapNode? node;
  final int? taskIndex;
  final int? milestoneIndex;
  final int? targetNodeIndex;

  bool get isTreasure => milestoneIndex != null;

  /// Builds the complete list of items including milestone treasures every 5 tasks
  static List<RoadmapItem> buildItems(List<RoadmapNode> nodes) {
    final List<RoadmapItem> items = [];
    for (int i = 0; i < nodes.length; i++) {
      items.add(RoadmapItem.node(nodes[i], i));
      if ((i + 1) % 5 == 0) {
        final milestoneIndex = (i + 1) ~/ 5;
        items.add(RoadmapItem.treasure(milestoneIndex, i));
      }
    }
    return items;
  }
}
