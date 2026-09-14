import 'package:MatchIn/features/jobs/presentation/widgets/jobs_info_job_card.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/matching_status.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.workMode,
    required this.experience,
    required this.jobType,
    required this.postedDate,
    required this.matchScore,
    required this.matchReason,
    this.isSaved = false,
    this.onTap,
    this.onApply,
    this.onSave,
  });

  final String title;
  final String company;
  final String location;
  final String workMode;
  final String experience;
  final String jobType;
  final String postedDate;
  final int matchScore;
  final String matchReason;

  final bool isSaved;

  final VoidCallback? onTap;
  final VoidCallback? onApply;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _JobHeader(
                title: title,
                company: company,
                isSaved: isSaved,
                onSave: onSave,
              ),

              SizedBox(height: 14.h),

              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: [
                  JobsInfoJobCard(label: location),
                  JobsInfoJobCard(label: experience),
                  JobsInfoJobCard(label: jobType),
                ],
              ),

              SizedBox(height: 8.h),

              _JobMetaData(
                workMode: workMode,
                postedDate: postedDate,
              ),

              SizedBox(height: 14.h),

              Divider(height: 1.h),

              SizedBox(height: 14.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        MatchingStatus(score: matchScore),
                        SizedBox(height: 6.h),
                        Text(
                          matchReason,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(
                                color: theme
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 12.w),

                  ElevatedButton(
                    // UI First:
                    // Keep the button enabled until real logic is connected.
                    onPressed: onApply ?? () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(96.w, 40.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(S.of(context).applyNow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobHeader extends StatelessWidget {
  const _JobHeader({
    required this.title,
    required this.company,
    required this.isSaved,
    required this.onSave,
  });

  final String title;
  final String company;
  final bool isSaved;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(9.r),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Text(
            _companyInitials(company),
            style: theme.textTheme.titleSmall,
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 3.h),
              Text(
                company,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 8.w),

        IconButton(
          onPressed: onSave ?? () {},
          visualDensity: VisualDensity.compact,
          icon: Icon(
            isSaved
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            color: isSaved
                ? theme.colorScheme.secondary
                : theme.colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
          ),
        ),
      ],
    );
  }

  String _companyInitials(String company) {
    final words = company
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) {
      return '?';
    }

    if (words.length == 1) {
      final word = words.first;

      return word
          .substring(0, word.length >= 2 ? 2 : 1)
          .toUpperCase();
    }

    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}

class _JobMetaData extends StatelessWidget {
  const _JobMetaData({
    required this.workMode,
    required this.postedDate,
  });

  final String workMode;
  final String postedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(
        alpha: 0.6,
      ),
    );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6.w,
      children: [
        Container(
          width: 6.r,
          height: 6.r,
          decoration: const BoxDecoration(
            color: Color(0xFF4F7A5A),
            shape: BoxShape.circle,
          ),
        ),
        Text(workMode, style: style),
        Text('•', style: style),
        Text(postedDate, style: style),
      ],
    );
  }
}
