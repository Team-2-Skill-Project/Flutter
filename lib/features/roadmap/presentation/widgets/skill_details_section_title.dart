import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillDetailsSectionTitle extends StatelessWidget {
  const SkillDetailsSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final l10n = context.l10n;

    return Row(
      children: [
        Icon(Icons.task_alt_rounded, size: 18.r, color: colors.primary),
        SizedBox(width: 8.w),
        Text(
          l10n.learningTasks,
          style: textTheme.labelLarge?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: colors.primary,
          ),
        ),
      ],
    );
  }
}
