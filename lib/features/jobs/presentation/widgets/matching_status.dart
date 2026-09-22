import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
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
        mainAxisSize: MainAxisSize.min,
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
            style: context.textTheme.labelMedium?.copyWith(
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
          label: percentage == null
              ? context.l10n.strongMatch
              : '$percentage% ${context.l10n.strongMatch}',
          color: AppColors.forestGreen,
        );

      case MatchingStatusType.good:
        return _MatchingStatusData(
          label: percentage == null
              ? context.l10n.goodMatch
              : '$percentage% ${context.l10n.goodMatch}',
          color: AppColors.amber,
        );

      case MatchingStatusType.percentage:
        return _MatchingStatusData(
          label:
              '${percentage ?? 0}% ${context.l10n.match}',
          color: context.colors.onSurface.withValues(
            alpha: 0.6,
          ),
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
