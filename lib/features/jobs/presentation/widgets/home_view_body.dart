import 'package:MatchIn/features/jobs/presentation/widgets/home_card_view_matches_jobs.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/home_header.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/home_search_field.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/recommended_jobs_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),

          const HomeHeader(),

          SizedBox(height: 20.h),

          const HomeSearchField(),

          SizedBox(height: 16.h),

          const HomeCardViewMatchesJobs(),

          SizedBox(height: 12.h),

          const RecommendedJobsSection(),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
