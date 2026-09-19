import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/job_card.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/matching_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RecommendedJobsSection extends StatelessWidget {
  const RecommendedJobsSection({super.key});

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

          const JobCard(
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
            skills: ['Flutter', 'REST API', 'Bloc'],
            showShareButton: true,
          ),

          SizedBox(height: 12.h),

          const JobCard(
            title: 'Mobile Developer Intern',
            company: 'CodeHub',
            location: 'Remote',
            workMode: 'Remote',
            experience: 'Entry Level',
            jobType: 'Internship',
            postedDate: 'Posted today',
            matchPercentage: 86,
            matchStatus: MatchingStatusType.percentage,
            showShareButton: true,
            skills: ['Flutter', 'Firebase', 'Git'],
          ),

          SizedBox(height: 12.h),

          const JobCard(
            title: 'Junior Software Engineer',
            company: 'NextStack',
            location: 'Giza',
            workMode: 'On-site',
            experience: 'Entry Level',
            jobType: 'Full-time',
            postedDate: 'Posted 3 days ago',
            matchPercentage: 74,
            matchStatus: MatchingStatusType.percentage,
            showShareButton: true,
            skills: ['Dart', 'Flutter'],
          ),
        ],
      ),
    );
  }
}
