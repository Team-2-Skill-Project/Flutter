import 'package:MatchIn/features/jobs/presentation/widgets/view_matches_button.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/view_matches_card_header.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCardViewMatchesJobs extends StatelessWidget {
  const HomeCardViewMatchesJobs({
    super.key,
    this.matchesCount = 12,
  });

  final int matchesCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: theme.dividerColor.withAlpha(50),
          ),
        ),
        child: Column(
          children: [
            // Top midnightBlue line
            Container(
              height: 4.h,
              width: 350.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(16.r),
                  topEnd: Radius.circular(16.r),
                ),
              ),
            ),

            // Card content
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // View Matches header
                  ViewMatchesCardHeader(
                    matchesCount: matchesCount,
                  ),

                  SizedBox(height: 14.h),

                  Text(
                    S.of(context).jobsMatchYourProfile,
                    style: theme.textTheme.titleMedium,
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    S.of(context).jobsMatchDescription,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.60),
                        ),
                  ),

                  SizedBox(height: 18.h),

                  // View Matches button
                  const ViewMatchesButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
