import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/jobs/presentation/widgets/job_card.dart';
import 'package:MatchIn/features/saved/data/repositories/applied_jobs_repository.dart';
import 'package:MatchIn/features/saved/presentation/models/applied_job_ui_model.dart';
import 'package:MatchIn/features/saved/presentation/models/saved_job_item_model.dart';
import 'package:MatchIn/features/saved/presentation/models/saved_tab_type.dart';
import 'package:MatchIn/features/saved/presentation/widgets/applied_job_card.dart';
import 'package:MatchIn/features/saved/presentation/widgets/saved_segmented_tab.dart';
import 'package:MatchIn/features/saved/presentation/widgets/saved_summary_bar.dart';
import 'package:MatchIn/features/saved/presentation/widgets/saved_top_bar.dart';

class SavedJobsView extends StatefulWidget {
  const SavedJobsView({super.key});

  @override
  State<SavedJobsView> createState() => _SavedJobsViewState();
}

class _SavedJobsViewState extends State<SavedJobsView> {
  SavedTabType _activeTab = SavedTabType.saved;

  // Local state initialized with static dummy data (ready for backend integration)
  late List<SavedJobItemModel> _savedJobs;

  @override
  void initState() {
    super.initState();
    _savedJobs = List.from(SavedJobItemModel.dummySavedJobs);
  }

  void _onTabChanged(SavedTabType tab) {
    if (_activeTab != tab) {
      setState(() {
        _activeTab = tab;
      });
    }
  }

  void _onToggleBookmark(int index) {
    setState(() {
      final job = _savedJobs[index];
      _savedJobs[index] = job.copyWith(
        isSaved: !job.isSaved,
      );
    });
  }

  void _onApplyToJob(SavedJobItemModel job) {
    // Record application in repository so it appears in Applied tab
    AppliedJobsRepository.instance.applyToSavedJob(job);
    // Navigate to apply flow
    context.push(AppRoutes.kapplyForRole);
  }

  @override
  Widget build(BuildContext context) {
    final isSavedTab = _activeTab == SavedTabType.saved;

    return ValueListenableBuilder<List<AppliedJobUiModel>>(
      valueListenable: AppliedJobsRepository.instance.appliedJobsNotifier,
      builder: (context, appliedJobs, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Top App Bar
                SavedTopBar(
                  title: isSavedTab ? 'Saved Jobs' : 'Applications',
                  onSearchTap: () {
                    // Future search integration
                  },
                ),

                // Segmented Tab Selector (Saved / Applied)
                SavedSegmentedTab(
                  activeTab: _activeTab,
                  onTabChanged: _onTabChanged,
                ),

                // Summary Bar
                SavedSummaryBar(
                  countText: isSavedTab
                      ? '${_savedJobs.length} saved opportunities'
                      : '${appliedJobs.length} applications',
                  actionLabel: isSavedTab ? 'Recently saved' : 'All statuses',
                  actionIcon: isSavedTab ? Icons.sort : Icons.filter_list,
                  onActionTap: () {
                    // Future sort/filter integration
                  },
                ),

                // List Content
                Expanded(
                  child: isSavedTab
                      ? _buildSavedJobsList()
                      : _buildAppliedJobsList(appliedJobs),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSavedJobsList() {
    if (_savedJobs.isEmpty) {
      return Center(
        child: Text(
          'No saved jobs yet',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: _savedJobs.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final job = _savedJobs[index];
        return JobCard(
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
          actionType: JobCardActionType.apply,
          onSave: () => _onToggleBookmark(index),
          onApply: () => _onApplyToJob(job),
        );
      },
    );
  }

  Widget _buildAppliedJobsList(List<AppliedJobUiModel> appliedJobs) {
    if (appliedJobs.isEmpty) {
      return Center(
        child: Text(
          'No applications yet',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: appliedJobs.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final application = appliedJobs[index];
        return AppliedJobCard(
          application: application,
          onCardTap: () {
            context.push(AppRoutes.ktrackingApplication);
          },
          onViewApplicationTap: () {
            context.push(AppRoutes.ktrackingApplication);
          },
        );
      },
    );
  }
}
