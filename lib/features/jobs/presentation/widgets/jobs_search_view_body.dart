import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/job_card.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/job_filter_chip.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/jobs_search_field.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/jobs_search_header.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/matching_status.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/search_results_header.dart';

class _SearchJobItem {
  _SearchJobItem({
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
    this.isSaved = false,
    this.showShareButton = true,
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
  bool isSaved;
  final bool showShareButton;
}

class JobsSearchViewBody extends StatefulWidget {
  const JobsSearchViewBody({super.key});

  @override
  State<JobsSearchViewBody> createState() => _JobsSearchViewBodyState();
}

class _JobsSearchViewBodyState extends State<JobsSearchViewBody> {
  late final List<_SearchJobItem> _jobs;

  @override
  void initState() {
    super.initState();
    _jobs = [
      _SearchJobItem(
        title: 'Junior Flutter Developer',
        company: 'TechNova',
        location: 'Cairo',
        workMode: 'Hybrid',
        experience: '0–2 years',
        jobType: 'Full-time',
        postedDate: '2 hours ago',
        skills: const ['Flutter', 'REST API', 'Bloc'],
        matchStatus: MatchingStatusType.strong,
        isSaved: true,
        showShareButton: true,
      ),
      _SearchJobItem(
        title: 'Mobile Developer Intern',
        company: 'CodeHub',
        location: 'Remote',
        workMode: 'Remote',
        experience: '0–1 years',
        jobType: 'Internship',
        postedDate: '2 hours ago',
        skills: const ['Flutter', 'Firebase', 'Git'],
        matchStatus: MatchingStatusType.good,
        isSaved: false,
        showShareButton: true,
      ),
      _SearchJobItem(
        title: 'Flutter UI Engineer',
        company: 'AppStudio',
        location: 'Giza',
        workMode: 'On-site',
        experience: 'Mid Level',
        jobType: 'Full-time',
        postedDate: '1 day ago',
        skills: const ['Dart', 'Flutter'],
        matchStatus: MatchingStatusType.percentage,
        matchPercentage: 75,
        isSaved: false,
        showShareButton: false,
      ),
    ];
  }

  void _toggleBookmark(int index) {
    setState(() {
      _jobs[index].isSaved = !_jobs[index].isSaved;
    });
  }

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
          const SearchResultsHeader(opportunitiesCount: 124),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                ..._jobs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final job = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: JobCard(
                      title: job.title,
                      company: job.company,
                      location: job.location,
                      workMode: job.workMode,
                      experience: job.experience,
                      jobType: job.jobType,
                      postedDate: job.postedDate,
                      skills: job.skills,
                      matchStatus: job.matchStatus,
                      matchPercentage: job.matchPercentage,
                      isSaved: job.isSaved,
                      showShareButton: job.showShareButton,
                      onSave: () => _toggleBookmark(index),
                      onApply: () {
                        context.push(AppRoutes.kapplyForRole);
                      },
                    ),
                  );
                }),
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
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
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
