import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/saved/presentation/models/applied_job_ui_model.dart';
import 'package:MatchIn/features/saved/presentation/models/saved_job_ui_model.dart';
import 'package:MatchIn/features/saved/presentation/models/saved_tab_type.dart';
import 'package:MatchIn/features/saved/presentation/widgets/applied_job_card.dart';
import 'package:MatchIn/features/saved/presentation/widgets/saved_job_card.dart';
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
  late List<SavedJobUiModel> _savedJobs;
  late List<AppliedJobUiModel> _appliedJobs;

  @override
  void initState() {
    super.initState();
    _savedJobs = List.from(SavedJobUiModel.dummySavedJobs);
    _appliedJobs = List.from(AppliedJobUiModel.dummyAppliedJobs);
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
      _savedJobs[index] = SavedJobUiModel(
        id: job.id,
        title: job.title,
        company: job.company,
        companyInitials: job.companyInitials,
        logoBgColor: job.logoBgColor,
        logoTextColor: job.logoTextColor,
        tags: job.tags,
        postedTime: job.postedTime,
        matchLevel: job.matchLevel,
        matchReason: job.matchReason,
        footerNote: job.footerNote,
        isSaved: !job.isSaved,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSavedTab = _activeTab == SavedTabType.saved;

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
                  : '${_appliedJobs.length} applications',
              actionLabel: isSavedTab ? 'Recently saved' : 'All statuses',
              actionIcon: isSavedTab ? Icons.sort : Icons.filter_list,
              onActionTap: () {
                // Future sort/filter integration
              },
            ),

            // List Content
            Expanded(
              child: isSavedTab ? _buildSavedJobsList() : _buildAppliedJobsList(),
            ),
          ],
        ),
      ),
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
        return SavedJobCard(
          job: job,
          onBookmarkTap: () => _onToggleBookmark(index),
          onApplyTap: () {
            // Future apply flow
          },
        );
      },
    );
  }

  Widget _buildAppliedJobsList() {
    if (_appliedJobs.isEmpty) {
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
      itemCount: _appliedJobs.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final application = _appliedJobs[index];
        return AppliedJobCard(
          application: application,
          onViewApplicationTap: () {
            // Future view application flow
          },
        );
      },
    );
  }
}
