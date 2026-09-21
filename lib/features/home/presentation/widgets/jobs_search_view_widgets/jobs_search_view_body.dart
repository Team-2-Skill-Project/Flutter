import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/features/home/presentation/widgets/jobs_search_view_widgets/job_card.dart';
import 'package:MatchIn/features/home/presentation/widgets/jobs_search_view_widgets/job_filter_chip.dart';
import 'package:MatchIn/features/home/presentation/widgets/jobs_search_view_widgets/jobs_search_field.dart';
import 'package:MatchIn/features/home/presentation/widgets/jobs_search_view_widgets/jobs_search_header.dart';
import 'package:MatchIn/features/home/presentation/widgets/home_view_widgets/matching_status.dart';
import 'package:MatchIn/features/home/presentation/widgets/jobs_search_view_widgets/search_results_header.dart';

class JobsSearchViewBody extends StatelessWidget {
  const JobsSearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const JobsSearchHeader(),
          SizedBox(height: 12.h),
          const JobsSearchField(),
          SizedBox(height: 16.h),
          const _FiltersList(),
          SizedBox(height: 16.h),
          const SearchResultsHeader(
            opportunitiesCount: 124,
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                const JobCard(
                  title: 'Junior Flutter Developer',
                  company: 'TechNova',
                  location: 'Cairo',
                  workMode: 'Hybrid',
                  experience: '0–2 years',
                  jobType: 'Full-time',
                  postedDate: '2 hours ago',
                  skills: ['Flutter', 'REST API', 'Bloc'],
                  matchStatus: MatchingStatusType.strong,
                  showShareButton: true,
                ),
                SizedBox(height: 12.h),
                const JobCard(
                  title: 'Mobile Developer Intern',
                  company: 'CodeHub',
                  location: 'Remote',
                  workMode: 'Remote',
                  experience: '0–1 years',
                  jobType: 'Internship',
                  postedDate: '2 hours ago',
                  skills: ['Flutter', 'Firebase', 'Git'],
                  matchStatus: MatchingStatusType.good,
                  showShareButton: true,
                ),
                SizedBox(height: 12.h),
                const JobCard(
                  title: 'Flutter UI Engineer',
                  company: 'AppStudio',
                  location: 'Giza',
                  workMode: 'On-site',
                  experience: 'Mid Level',
                  jobType: 'Full-time',
                  postedDate: '1 day ago',
                  skills: ['Dart', 'Flutter'],
                  matchStatus:
                      MatchingStatusType.percentage,
                  matchPercentage: 75,
                  showShareButton: false,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _FiltersList extends StatelessWidget {
  const _FiltersList();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
        ),
        children: [
          JobFilterChip(label: l10n.all, isSelected: true),
          SizedBox(width: 8.w),
          JobFilterChip(label: l10n.remote),
          SizedBox(width: 8.w),
          JobFilterChip(label: l10n.internship),
          SizedBox(width: 8.w),
          JobFilterChip(label: l10n.fullTime),
          SizedBox(width: 8.w),
          JobFilterChip(label: l10n.entryLevel),
        ],
      ),
    );
  }
}
