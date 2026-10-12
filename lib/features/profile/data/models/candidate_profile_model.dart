import 'package:MatchIn/features/profile/data/models/candidate_profile_details_model.dart';
import 'package:MatchIn/features/profile/data/models/candidate_project_model.dart';
import 'package:MatchIn/features/profile/data/models/candidate_skill_model.dart';
import 'package:MatchIn/features/profile/data/models/career_preference_model.dart';
import 'package:MatchIn/features/profile/data/models/cv_document_model.dart';
import 'package:MatchIn/features/profile/data/models/education_model.dart';
import 'package:MatchIn/features/profile/data/models/experience_model.dart';
import 'package:MatchIn/features/profile/data/models/profile_user_model.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_profile_entity.dart';

class CandidateProfileModel extends CandidateProfileEntity {
  const CandidateProfileModel({
    required super.profileExists,
    required ProfileUserModel super.user,
    CandidateProfileDetailsModel? super.profile,
    super.skills,
    super.projects,
    CareerPreferenceModel? super.careerPreferences,
    super.education,
    super.experience,
    CvDocumentModel? super.cvDocument,
  });

  factory CandidateProfileModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    if (userJson is! Map<String, dynamic>) {
      throw const FormatException('Invalid candidate profile: missing user');
    }
    final profileJson = json['profile'];
    if (profileJson != null && profileJson is! Map<String, dynamic>) {
      throw const FormatException('Invalid candidate profile: invalid profile');
    }

    return CandidateProfileModel(
      profileExists: json['profile_exists'] as bool? ?? false,
      user: ProfileUserModel.fromJson(userJson),
      profile: profileJson == null
          ? null
          : CandidateProfileDetailsModel.fromJson(
              profileJson as Map<String, dynamic>,
            ),
      skills: _skillList(json['skills']),
      projects: _projectList(json['projects']),
      careerPreferences: _careerPreferences(json['career_preferences']),
      education: _educationList(json['education']),
      experience: _experienceList(json['experience']),
      cvDocument: _cvDocument(json['cv_document']),
    );
  }

  static List<CandidateSkillModel> _skillList(dynamic value) {
    if (value is! List) {
      return const [];
    }
    final result = <CandidateSkillModel>[];
    for (final item in value) {
      if (item is Map<String, dynamic>) {
        try {
          result.add(CandidateSkillModel.fromJson(item));
        } catch (_) {
          continue;
        }
      }
    }
    return result;
  }

  static List<CandidateProjectModel> _projectList(dynamic value) {
    if (value is! List) {
      return const [];
    }
    final result = <CandidateProjectModel>[];
    for (final item in value) {
      if (item is Map<String, dynamic>) {
        try {
          result.add(CandidateProjectModel.fromJson(item));
        } catch (_) {
          continue;
        }
      }
    }
    return result;
  }

  static CareerPreferenceModel? _careerPreferences(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is! Map<String, dynamic>) {
      return null;
    }
    try {
      return CareerPreferenceModel.fromJson(value);
    } catch (_) {
      return null;
    }
  }

  static List<EducationModel> _educationList(dynamic value) {
    if (value is! List) {
      return const [];
    }
    final result = <EducationModel>[];
    for (final item in value) {
      if (item is Map<String, dynamic>) {
        try {
          result.add(EducationModel.fromJson(item));
        } catch (_) {
          continue;
        }
      }
    }
    return result;
  }

  static List<ExperienceModel> _experienceList(dynamic value) {
    if (value is! List) {
      return const [];
    }
    final result = <ExperienceModel>[];
    for (final item in value) {
      if (item is Map<String, dynamic>) {
        try {
          result.add(ExperienceModel.fromJson(item));
        } catch (_) {
          continue;
        }
      }
    }
    return result;
  }

  static CvDocumentModel? _cvDocument(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is! Map<String, dynamic>) {
      return null;
    }
    try {
      return CvDocumentModel.fromJson(value);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_exists': profileExists,
      'user': ProfileUserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        isActive: user.isActive,
        phone: user.phone,
        avatar: user.avatar,
      ).toJson(),
      'profile': profile == null
          ? null
          : CandidateProfileDetailsModel(
              id: profile!.id,
              dateOfBirth: profile!.dateOfBirth,
              gender: profile!.gender,
              jobTitle: profile!.jobTitle,
              country: profile!.country,
              state: profile!.state,
              city: profile!.city,
              githubUrl: profile!.githubUrl,
              linkedinUrl: profile!.linkedinUrl,
              militaryStatus: profile!.militaryStatus,
              professionalSummary: profile!.professionalSummary,
            ).toJson(),
      'skills': skills.map((skill) {
        if (skill is CandidateSkillModel) {
          return skill.toJson();
        }
        return {
          'id': skill.id,
          'skill_id': skill.skillId,
          'source': skill.source,
          'proficiency_level': skill.proficiencyLevel,
          'skill': {'id': skill.skillId, 'name': skill.name},
        };
      }).toList(),
      'projects': projects.map((project) {
        if (project is CandidateProjectModel) {
          return project.toJson();
        }
        return {
          'id': project.id,
          'name': project.name,
          'description': project.description,
          'technologies': project.technologies,
          'project_url': project.projectUrl,
          'github_url': project.githubUrl,
          'source': project.source,
          'start_date': project.startDate,
          'end_date': project.endDate,
        };
      }).toList(),
      'career_preferences': careerPreferences == null
          ? null
          : (careerPreferences is CareerPreferenceModel
                ? (careerPreferences as CareerPreferenceModel).toJson()
                : {
                    'id': careerPreferences!.id,
                    'target_role': careerPreferences!.targetRole,
                    'job_type': careerPreferences!.jobType,
                    'work_mode': careerPreferences!.workMode,
                    'preferred_country': careerPreferences!.preferredCountry,
                    'preferred_city': careerPreferences!.preferredCity,
                    'experience_level': careerPreferences!.experienceLevel,
                    'career_goal': careerPreferences!.careerGoal,
                    'open_to_relocation': careerPreferences!.openToRelocation,
                    'target_roles': careerPreferences!.targetRoles,
                    'preferred_industries':
                        careerPreferences!.preferredIndustries,
                  }),
      'education': education.map((item) {
        if (item is EducationModel) {
          return item.toJson();
        }
        return {
          'id': item.id,
          'degree': item.degree,
          'institution': item.institution,
          'start_date': item.startDate,
          'end_date': item.endDate,
          'grade': item.grade,
        };
      }).toList(),
      'experience': experience.map((item) {
        if (item is ExperienceModel) {
          return item.toJson();
        }
        return {
          'id': item.id,
          'job_title': item.jobTitle,
          'company_name': item.companyName,
          'employment_type': item.employmentType,
          'country': item.country,
          'city': item.city,
          'description': item.description,
          'technologies': item.technologies,
          'start_date': item.startDate,
          'end_date': item.endDate,
          'is_current': item.isCurrent,
        };
      }).toList(),
      'cv_document': cvDocument == null
          ? null
          : (cvDocument is CvDocumentModel
                ? (cvDocument as CvDocumentModel).toJson()
                : {
                    'id': cvDocument!.id,
                    'file_name': cvDocument!.fileName,
                    'file_url': cvDocument!.fileUrl,
                    'status': cvDocument!.status,
                    'updated_at': cvDocument!.updatedAt,
                  }),
    };
  }
}
