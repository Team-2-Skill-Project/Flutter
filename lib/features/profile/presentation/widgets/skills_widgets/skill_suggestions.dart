import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/generated/l10n.dart';

class SkillSuggestions extends StatelessWidget {
  const SkillSuggestions({
    required this.skills,
    required this.onSkillPressed,
    super.key,
  });

  final List<String> skills;
  final ValueChanged<String> onSkillPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final S locale = S.of(context);

    return Row(
      children: [
        Text(
          '${locale.suggestions}:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                skills.length,
                (index) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: index == skills.length - 1
                        ? 0
                        : 8.w,
                  ),
                  child: ActionChip(
                    onPressed: () =>
                        onSkillPressed(skills[index]),
                    avatar: Icon(
                      Icons.add_rounded,
                      size: 18.r,
                      color: colors.onSurface,
                    ),
                    label: Text(skills[index]),
                    backgroundColor: colors.surface,
                    side: BorderSide(
                      color: colors.outlineVariant,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        100.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
