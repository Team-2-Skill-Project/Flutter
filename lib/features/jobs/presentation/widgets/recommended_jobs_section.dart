import 'package:MatchIn/features/jobs/presentation/widgets/job_card.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  S.of(context).recommendedForYou,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(S.of(context).seeAll),
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
            matchScore: 92,
            matchReason:
                'Matches your Flutter & REST API skills',
            isSaved: true,
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
            matchScore: 86,
            matchReason:
                'Recommended based on your target role',
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
            matchScore: 74,
            matchReason: 'Matches problem solving skills',
          ),
        ],
      ),
    );
  }
}
