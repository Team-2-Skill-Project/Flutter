import 'package:MatchIn/features/jobs/presentation/widgets/job_card.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/job_filter_chip.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/jobs_search_field.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/jobs_search_header.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/matching_status.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/search_results_header.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
        ),
        children: [
          JobFilterChip(
            label: S.of(context).all,
            isSelected: true,
          ),

          const _SizedBox(),

          JobFilterChip(label: S.of(context).all),

          const _SizedBox(),

          JobFilterChip(label: S.of(context).all),

          const _SizedBox(),

          JobFilterChip(label: S.of(context).all),

          const _SizedBox(),

          JobFilterChip(label: S.of(context).all),
        ],
      ),
    );
  }
}

class _SizedBox extends StatelessWidget {
  const _SizedBox();

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 8.w);
  }
}
