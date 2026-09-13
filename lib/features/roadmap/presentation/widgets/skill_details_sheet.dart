import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/info_item.dart';
import 'package:flutter/material.dart';

class SkillDetailsSheet extends StatelessWidget {
  const SkillDetailsSheet({super.key, required this.node});
  final RoadmapNode node;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            node.title,
            style: const TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F365C),
            ),
          ),

          if (node.subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              node.subtitle!,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF707780),
              ),
            ),
          ],

          const SizedBox(height: 24),

          const Text(
            'Why you need it',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'This skill is important for your target '
            'Flutter Developer roles.',
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              InfoItem(title: 'Duration', value: node.duration ?? '-'),
              const SizedBox(width: 24),
              InfoItem(title: 'XP Reward', value: '+${node.xp ?? 0}'),
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F365C),
                foregroundColor: Colors.white,
              ),
              child: const Text('Start Learning'),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
