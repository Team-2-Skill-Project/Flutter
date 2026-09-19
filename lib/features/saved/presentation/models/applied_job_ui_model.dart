import 'package:flutter/material.dart';
import 'package:MatchIn/features/saved/presentation/models/saved_job_ui_model.dart';

enum ApplicationStatus {
  applied,
  inReview,
  interview,
}

class AppliedJobUiModel {
  const AppliedJobUiModel({
    required this.id,
    required this.title,
    required this.company,
    required this.companyInitials,
    required this.logoBgColor,
    required this.logoTextColor,
    required this.status,
    required this.tags,
    required this.appliedTime,
    this.matchLevel,
    required this.footerStatus,
    this.highlightNote,
  });

  final String id;
  final String title;
  final String company;
  final String companyInitials;
  final Color logoBgColor;
  final Color logoTextColor;
  final ApplicationStatus status;
  final List<String> tags;
  final String appliedTime;
  final MatchLevel? matchLevel;
  final String footerStatus;
  final String? highlightNote;

  /// Static dummy data ready to be swapped with backend data later
  static const List<AppliedJobUiModel> dummyAppliedJobs = [
    AppliedJobUiModel(
      id: '1',
      title: 'Junior Flutter Developer',
      company: 'TechNova',
      companyInitials: 'TN',
      logoBgColor: Color(0x0D1F365C), // rgba(31, 54, 92, 0.05)
      logoTextColor: Color(0xFF1F365C),
      status: ApplicationStatus.applied,
      tags: ['Cairo', 'Full-time'],
      appliedTime: 'Applied 2 days ago',
      matchLevel: MatchLevel.strong,
      footerStatus: 'Application submitted',
    ),
    AppliedJobUiModel(
      id: '2',
      title: 'Mobile Developer',
      company: 'PixelStack',
      companyInitials: 'PS',
      logoBgColor: Color(0x1AD06B4F), // rgba(208, 107, 79, 0.1)
      logoTextColor: Color(0xFFD06B4F),
      status: ApplicationStatus.inReview,
      tags: ['Remote', 'Full-time'],
      appliedTime: 'Applied 5 days ago',
      matchLevel: MatchLevel.strong,
      footerStatus: 'Profile under evaluation',
    ),
    AppliedJobUiModel(
      id: '3',
      title: 'Flutter Developer Intern',
      company: 'CodeHub',
      companyInitials: 'CH',
      logoBgColor: Color(0x26D4A72C), // rgba(212, 167, 44, 0.15)
      logoTextColor: Color(0xFF9E7815),
      status: ApplicationStatus.interview,
      tags: ['Cairo', 'Internship'],
      appliedTime: 'Applied 1 week ago',
      matchLevel: null,
      footerStatus: 'Round 1 Technical',
      highlightNote: 'Interview scheduled — check your email',
    ),
  ];
}
