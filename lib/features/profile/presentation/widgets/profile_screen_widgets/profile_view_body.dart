import 'package:MatchIn/core/utils/profile_formatters.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/career_preferences_widgets/career_preferences_profile_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/cv_widgets/cv_profile_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/education_widgets/education_profile_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/education_widgets/education_profile_item_data.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/experience_widgets/experience_profile_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/experience_widgets/experience_profile_item_data.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/profile_header.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/profile_overview_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/projects_widgets/projects_profile_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/skills_widgets/skills_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
      children: [
        const ProfileHeader(),
        SizedBox(height: 16.h),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (state is ProfileFailure) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(child: Text(state.message)),
              );
            }

            if (state is ProfileSuccess) {
              final profile = state.profile;
              final details = profile.profile;
              final careerPreferences = profile.careerPreferences;
              final cvDocument = profile.cvDocument;

              return Column(
                children: [
                  ProfileOverviewCard(
                    name: profile.user.name,
                    avatarUrl: profile.user.avatar,
                    jobTitle: details?.jobTitle ?? '',
                    location: ProfileFormatters.location(details),
                    summary: details?.professionalSummary ?? '',
                    githubUrl: details?.githubUrl,
                    linkedinUrl: details?.linkedinUrl,
                  ),
                  SizedBox(height: 16.h),
                  EducationProfileCard(
                    educations: profile.education
                        .map(
                          (item) => EducationProfileItemData(
                            degree: item.degree,
                            institution: item.institution,
                            startDate: item.startDate,
                            endDate: item.endDate,
                            grade: item.grade,
                          ),
                        )
                        .toList(),
                    onEdit: () {
                      context.push('/profile/editEducation');
                    },
                  ),
                  SizedBox(height: 16.h),
                  ExperienceProfileCard(
                    experiences: profile.experience
                        .map(
                          (item) => ExperienceProfileItemData(
                            jobTitle: item.jobTitle,
                            companyName: item.companyName,
                            employmentType: item.employmentType,
                            country: item.country,
                            city: item.city,
                            description: item.description,
                            technologies: item.technologies,
                            startDate: item.startDate,
                            endDate: item.endDate,
                            isCurrent: item.isCurrent,
                          ),
                        )
                        .toList(),
                    onEdit: () {
                      context.push('/profile/editExperience');
                    },
                  ),
                  SizedBox(height: 16.h),
                  SkillsProfileCard(
                    skills: profile.skills.map((skill) => skill.name).toList(),
                    onEdit: () {
                      context.push('/profile/skills');
                    },
                    onAddSkill: () {
                      context.push('/profile/skills');
                    },
                  ),
                  SizedBox(height: 16.h),
                  ProjectsProfileCard(
                    projects: profile.projects,
                    onEdit: () {
                      context.push('/profile/projects');
                    },
                  ),
                  SizedBox(height: 16.h),
                  CvProfileCard(
                    hasCv:
                        cvDocument?.fileName != null ||
                        cvDocument?.fileUrl != null,
                    fileName: cvDocument?.fileName,
                    status: cvDocument?.status,
                    updatedText: cvDocument?.updatedAt,
                  ),
                  SizedBox(height: 16.h),
                  CareerPreferencesProfileCard(
                    targetRole: careerPreferences?.targetRole,
                    jobType: careerPreferences?.jobType,
                    workMode: careerPreferences?.workMode,
                    preferredLocation: _preferredLocation(
                      careerPreferences?.preferredCountry,
                      careerPreferences?.preferredCity,
                    ),
                    experienceLevel: careerPreferences?.experienceLevel,
                    onEdit: () {
                      context.push('/profile/careerPref');
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

String? _preferredLocation(String? country, String? city) {
  final parts = [
    city,
    country,
  ].where((part) => part != null && part.trim().isNotEmpty).toList();
  if (parts.isEmpty) {
    return null;
  }
  return parts.join(', ');
}
