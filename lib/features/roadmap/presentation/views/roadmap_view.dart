import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_path_painter.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_details_sheet.dart';
import 'package:flutter/material.dart';

class RoadmapView extends StatelessWidget {
  const RoadmapView({super.key, required this.nodes});
  final List<RoadmapNode> nodes;

  static const double nodeSize = 64;
  static const double itemHeight = 145;

  @override
  Widget build(BuildContext context) {
    final height = nodes.length * itemHeight;

    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            // The roadmap path
            Positioned.fill(
              child: CustomPaint(
                painter: RoadmapPathPainter(
                  itemCount: nodes.length,
                  itemHeight: itemHeight,
                  nodeSize: nodeSize,
                ),
              ),
            ),

            // The nodes
            ...List.generate(nodes.length, (index) {
              return _buildNode(context, node: nodes[index], index: index);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNode(
    BuildContext context, {
    required RoadmapNode node,
    required int index,
  }) {
    final isLeft = index.isEven;

    return Positioned(
      top: index * itemHeight,
      left: isLeft ? 40 : null,
      right: isLeft ? null : 40,
      child: RoadmapNodeWidget(
        node: node,
        onTap: () {
          _onNodeTap(context, node);
        },
      ),
    );
  }

  void _onNodeTap(BuildContext context, RoadmapNode node) {
    if (node.status == RoadmapNodeStatus.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete the previous skill first.')),
      );

      return;
    }

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return SkillDetailsSheet(node: node);
      },
    );
  }
}
