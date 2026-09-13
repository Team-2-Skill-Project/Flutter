import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:flutter/material.dart';

class RoadmapNodeWidget extends StatelessWidget {
  const RoadmapNodeWidget({super.key, required this.node, required this.onTap});
  final RoadmapNode node;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 130,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (node.status == RoadmapNodeStatus.current)
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color.withValues(alpha: .25),
                        width: 6,
                      ),
                    ),
                  ),

                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(_getIcon(), color: Colors.white, size: 28),
                  ),
                ),

                if (node.status == RoadmapNodeStatus.current)
                  Positioned(
                    bottom: -12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F365C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'START',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            Text(
              node.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xFF222831),
              ),
            ),

            if (node.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                node.subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  color: Color(0xFF707780),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    switch (node.status) {
      case RoadmapNodeStatus.completed:
        return const Color(0xFF4F7A5A);

      case RoadmapNodeStatus.current:
        return const Color(0xFF1F365C);

      case RoadmapNodeStatus.available:
        return const Color(0xFFD4A72C);

      case RoadmapNodeStatus.locked:
        return const Color(0xFFE5E1DA);

      case RoadmapNodeStatus.milestone:
        return const Color(0xFFD4A72C);
    }
  }

  IconData _getIcon() {
    switch (node.status) {
      case RoadmapNodeStatus.completed:
        return Icons.check;

      case RoadmapNodeStatus.current:
        return Icons.play_arrow_rounded;

      case RoadmapNodeStatus.available:
        return Icons.school_outlined;

      case RoadmapNodeStatus.locked:
        return Icons.lock_outline;

      case RoadmapNodeStatus.milestone:
        return Icons.workspace_premium_outlined;
    }
  }
}
