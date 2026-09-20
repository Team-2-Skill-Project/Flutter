import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/job_card.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/matching_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class _JobItemData {
  _JobItemData({
    required this.id,
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

  final String id;
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

class RecommendedJobsSection extends StatefulWidget {
  const RecommendedJobsSection({super.key});

  @override
  State<RecommendedJobsSection> createState() => _RecommendedJobsSectionState();
}

class _RecommendedJobsSectionState extends State<RecommendedJobsSection> {
  late final List<_JobItemData> _jobs;

  @override
  void initState() {
    super.initState();
    _jobs = [
      _JobItemData(
        id: 'rec_1',
        title: 'Junior Flutter Developer',
        company: 'TechNova',
        location: 'Cairo',
        workMode: 'Hybrid',
        experience: '0–2 years',
        jobType: 'Full-time',
        postedDate: 'Posted 2 days ago',
        matchPercentage: 92,
        matchStatus: MatchingStatusType.percentage,
        isSaved: true,
        skills: const ['Flutter', 'REST API', 'Bloc'],
        showShareButton: true,
      ),
      _JobItemData(
        id: 'rec_2',
        title: 'Mobile Developer Intern',
        company: 'CodeHub',
        location: 'Remote',
        workMode: 'Remote',
        experience: 'Entry Level',
        jobType: 'Internship',
        postedDate: 'Posted today',
        matchPercentage: 86,
        matchStatus: MatchingStatusType.percentage,
        isSaved: false,
        skills: const ['Flutter', 'Firebase', 'Git'],
        showShareButton: true,
      ),
      _JobItemData(
        id: 'rec_3',
        title: 'Junior Software Engineer',
        company: 'NextStack',
        location: 'Giza',
        workMode: 'On-site',
        experience: 'Entry Level',
        jobType: 'Full-time',
        postedDate: 'Posted 3 days ago',
        matchPercentage: 74,
        matchStatus: MatchingStatusType.percentage,
        isSaved: false,
        skills: const ['Dart', 'Flutter'],
        showShareButton: true,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.recommendedForYou,
                  style: context.textTheme.titleMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push(AppRoutes.kJobsSearchView);
                },
                child: Text(context.l10n.seeAll),
              ),
            ],
          ),
          SizedBox(height: 12.h),
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
    );
  }
}
