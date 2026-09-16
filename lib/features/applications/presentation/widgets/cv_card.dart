import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CvCard extends StatelessWidget {
  const CvCard({super.key, this.onView, this.onChange});

  final VoidCallback? onView;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.cvResume,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ahmed_Mohamed_CV.pdf',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            s.updatedFiveDaysAgo,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(
                                  color: theme
                                      .colorScheme
                                      .onSurface
                                      .withValues(
                                        alpha: 0.6,
                                      ),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.forestGreen
                            .withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(
                          20.r,
                        ),
                      ),
                      child: Text(
                        s.ready,
                        style: theme.textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.forestGreen,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                const Divider(height: 1),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: onView ?? () {},
                      icon: const Icon(
                        Icons.visibility_outlined,
                      ),
                      label: Text(s.view),
                    ),
                    SizedBox(width: 8.w),
                    TextButton.icon(
                      onPressed: onChange ?? () {},
                      icon: const Icon(Icons.swap_horiz),
                      label: Text(s.change),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
