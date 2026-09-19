import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class SuggestedQuestionsGrid extends StatelessWidget {
  const SuggestedQuestionsGrid({super.key, required this.onSelectQuestion});

  final Function(String) onSelectQuestion;

  static const List<Map<String, String>> _questions = [
    {
      'icon': '📝',
      'title': 'Resume Optimization',
      'prompt': 'How can I optimize my CV for Flutter developer roles?',
    },
    {
      'icon': '🎯',
      'title': 'Interview Prep',
      'prompt': 'What are the top technical interview questions for Dart and Flutter?',
    },
    {
      'icon': '🚀',
      'title': 'Career Growth',
      'prompt': 'What steps should I take to become a Senior Mobile Architect?',
    },
    {
      'icon': '💡',
      'title': 'Job Fit Analysis',
      'prompt': 'How does MatchIn calculate my job match percentage?',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            s.suggestedQuestions,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
          ),
          itemCount: _questions.length,
          itemBuilder: (context, index) {
            final q = _questions[index];
            return InkWell(
              onTap: () => onSelectQuestion(q['prompt']!),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(q['icon']!, style: const TextStyle(fontSize: 22)),
                    Text(
                      q['title']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
