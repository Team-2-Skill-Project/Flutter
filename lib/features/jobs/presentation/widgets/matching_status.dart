import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MatchingStatusType { strong, good, percentage }

class MatchingStatus extends StatelessWidget {
  const MatchingStatus({
    super.key,
    required this.type,
    this.percentage,
  });

  final MatchingStatusType type;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final data = _getStatusData(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: data.color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          if (type != MatchingStatusType.percentage) ...[
            Container(
              width: 7.r,
              height: 7.r,
              decoration: BoxDecoration(
                color: data.color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
          ],
          Text(
            data.label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: data.color,
            ),
          ),
        ],
      ),
    );
  }

  _MatchingStatusData _getStatusData(BuildContext context) {
    switch (type) {
      case MatchingStatusType.strong:
        return _MatchingStatusData(
          label: S.of(context).strongMatch,
          color: AppColors.forestGreen,
        );

      case MatchingStatusType.good:
        return _MatchingStatusData(
          label: S.of(context).goodMatch,
          color: AppColors.amber,
        );

      case MatchingStatusType.percentage:
        return _MatchingStatusData(
          label:
              '${percentage ?? 0}% ${S.of(context).match}',
          color: Theme.of(context).colorScheme.onSurface
              .withValues(alpha: 0.6),
        );
    }
  }
}

class _MatchingStatusData {
  const _MatchingStatusData({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;
}
