import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/features/jobsAndApplications/presentation/widgets/job_details_widgets/jobs_info_job_card.dart';
import 'package:MatchIn/features/home/presentation/widgets/home_view_widgets/matching_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
    required this.skills,
    required this.matchStatus,
    this.matchPercentage,
    this.showShareButton = false,
    this.isSaved = false,
    this.onShare,
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

  final List<String> skills;

  final MatchingStatusType matchStatus;
  final int? matchPercentage;

  final bool showShareButton;
  final bool isSaved;

  final VoidCallback? onShare;
  final VoidCallback? onTap;
  final VoidCallback? onApply;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          GoRouter.of(context)
              .push(AppRoutes.kJobDetailsView);
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _JobHeader(
                title: title,
                company: company,
                isSaved: isSaved,
                showShareButton: showShareButton,
                onShare: onShare,
                onSave: onSave,
              ),

              SizedBox(height: 14.h),

              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  JobsInfoJobCard(
                    label: location,
                    icon: Icons.location_on_outlined,
                  ),
                  JobsInfoJobCard(label: jobType),
                  JobsInfoJobCard(label: workMode),
                  JobsInfoJobCard(
                    label: experience,
                    icon: Icons.work_outline_rounded,
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              _PostedDate(postedDate: postedDate),

              if (skills.isNotEmpty) ...[
                SizedBox(height: 14.h),

                _SkillsSection(skills: skills),
              ],

              SizedBox(height: 16.h),

              Divider(height: 1.h),

              SizedBox(height: 14.h),

              Row(
                children: [
                  MatchingStatus(
                    type: matchStatus,
                    percentage: matchPercentage,
                  ),

                  const Spacer(),

                  ElevatedButton(
                    onPressed:
                        onApply ??
                        () {
                          GoRouter.of(
                            context,
                          ).push(AppRoutes.kapplyForRole);
                        },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(110.w, 42.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                      ),
                    ),
                    child: Text(context.l10n.applyNow),
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
    required this.showShareButton,
    required this.onSave,
    this.onShare,
  });

  final String title;
  final String company;
  final bool isSaved;
  final bool showShareButton;

  final VoidCallback? onShare;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Text(
            _companyInitials(company),
            style: context.textTheme.titleMedium,
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium
                    ?.copyWith(
                      color: context.colors.onSurface
                          .withValues(alpha: 0.6),
                    ),
              ),

              SizedBox(height: 3.h),

              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
        ),

        if (showShareButton)
          IconButton(
            onPressed: onShare ?? () {},
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.share_outlined),
          ),

        IconButton(
          onPressed: onSave ?? () {},
          visualDensity: VisualDensity.compact,
          icon: Icon(
            isSaved
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            color: isSaved
                ? context.colors.secondary
                : context.colors.onSurface.withValues(
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

    return '${words.first[0]}${words[1][0]}'.toUpperCase();
  }
}

class _PostedDate extends StatelessWidget {
  const _PostedDate({required this.postedDate});

  final String postedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.schedule_rounded,
          size: 16.sp,
          color: context.colors.onSurface.withValues(
            alpha: 0.55,
          ),
        ),

        SizedBox(width: 4.w),

        Text(
          postedDate,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurface.withValues(
              alpha: 0.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: skills
          .map(
            (skill) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 1.h,
              ),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: context.theme.dividerColor,
                ),
              ),
              child: Text(
                skill,
                style: context.textTheme.labelMedium,
              ),
            ),
          )
          .toList(),
    );
  }
}
