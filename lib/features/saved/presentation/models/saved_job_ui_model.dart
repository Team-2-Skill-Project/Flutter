import 'package:flutter/material.dart';

enum MatchLevel {
  strong,
  good,
}

class SavedJobUiModel {
  const SavedJobUiModel({
    required this.id,
    required this.title,
    required this.company,
    required this.companyInitials,
    required this.logoBgColor,
    required this.logoTextColor,
    required this.tags,
    required this.postedTime,
    required this.matchLevel,
    required this.matchReason,
    this.footerNote = 'Saved to your list',
    this.isSaved = true,
  });

  final String id;
  final String title;
  final String company;
  final String companyInitials;
  final Color logoBgColor;
  final Color logoTextColor;
  final List<String> tags;
  final String postedTime;
  final MatchLevel matchLevel;
  final String matchReason;
  final String footerNote;
  final bool isSaved;

  /// Static dummy data ready to be swapped with backend data later
  static const List<SavedJobUiModel> dummySavedJobs = [
    SavedJobUiModel(
      id: '1',
      title: 'Junior Flutter Developer',
      company: 'TechNova',
      companyInitials: 'TN',
      logoBgColor: Color(0x0D1F365C), // rgba(31, 54, 92, 0.05)
      logoTextColor: Color(0xFF1F365C),
      tags: ['Cairo', '0–2 years', 'Full-time', 'Hybrid'],
      postedTime: 'Posted 2 days ago',
      matchLevel: MatchLevel.strong,
      matchReason: 'Matches your Flutter & REST API skills',
      footerNote: 'Saved to your list',
      isSaved: true,
    ),
    SavedJobUiModel(
      id: '2',
      title: 'Mobile Developer Intern',
      company: 'CodeHub',
      companyInitials: 'CH',
      logoBgColor: Color(0x1AD06B4F), // rgba(208, 107, 79, 0.1)
      logoTextColor: Color(0xFFD06B4F),
      tags: ['Remote', 'Internship'],
      postedTime: 'Posted today',
      matchLevel: MatchLevel.strong,
      matchReason: 'Recommended based on your target role',
      footerNote: 'Saved to your list',
      isSaved: true,
    ),
    SavedJobUiModel(
      id: '3',
      title: 'Junior Software Engineer',
      company: 'NextStack',
      companyInitials: 'NS',
      logoBgColor: Color(0x26D4A72C), // rgba(212, 167, 44, 0.15)
      logoTextColor: Color(0xFF9E7815),
      tags: ['Giza', 'Entry Level', 'Full-time'],
      postedTime: 'Posted 3 days ago',
      matchLevel: MatchLevel.good,
      matchReason: 'Good match for foundational engineering skills',
      footerNote: 'Saved to your list',
      isSaved: true,
    ),
  ];
}
