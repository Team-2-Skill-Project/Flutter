import 'package:dartz/dartz.dart';
import 'package:MatchIn/core/errors/failures.dart';
import 'package:MatchIn/features/profile/domain/entities/add_candidate_project_params.dart';
import 'package:MatchIn/features/profile/domain/entities/add_candidate_skill_params.dart';
import 'package:MatchIn/features/profile/domain/entities/add_education_params.dart';
import 'package:MatchIn/features/profile/domain/entities/add_experience_params.dart';
import 'package:MatchIn/features/profile/domain/entities/avatar_upload_input.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_profile_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_project_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_skill_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/career_preference_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_upload_input.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_upload_receipt.dart';
import 'package:MatchIn/features/profile/domain/entities/education_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/experience_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/save_career_preferences_params.dart';
import 'package:MatchIn/features/profile/domain/entities/skill_search_result_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/update_candidate_profile_params.dart';
import 'package:MatchIn/features/profile/domain/entities/update_candidate_project_params.dart';
import 'package:MatchIn/features/profile/domain/entities/update_education_params.dart';
import 'package:MatchIn/features/profile/domain/entities/update_experience_params.dart';
import 'package:MatchIn/features/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepository {
  // Candidate Profile
  Future<Either<Failure, CandidateProfileEntity>> getCandidateProfile();

  Future<Either<Failure, CandidateProfileEntity?>> getCachedCandidateProfile();

  Future<Either<Failure, CandidateProfileEntity>> getCandidateProfileForEdit();

  Future<Either<Failure, UserProfileEntity>> getUserProfile();

  // Candidate Skills
  Future<Either<Failure, List<CandidateSkillEntity>>> getCandidateSkills();

  Future<Either<Failure, CandidateSkillEntity>> addCandidateSkill(
    AddCandidateSkillParams params,
  );

  Future<Either<Failure, Unit>> removeCandidateSkill(int candidateSkillId);
  Future<Either<Failure, List<SkillSearchResultEntity>>> searchSkills(
    String query,
  );

  // Candidate Projects
  Future<Either<Failure, List<CandidateProjectEntity>>> getProjects();

  Future<Either<Failure, CandidateProjectEntity>> getProject(int projectId);

  /// Returns a null entity when the mutation succeeded but the response
  /// payload was incomplete. Callers must refresh from GET in that case.
  Future<Either<Failure, CandidateProjectEntity?>> addCandidateProject(
    AddCandidateProjectParams params,
  );

  /// Same incomplete-payload contract as [addCandidateProject].
  Future<Either<Failure, CandidateProjectEntity?>> updateCandidateProject(
    UpdateCandidateProjectParams params,
  );

  Future<Either<Failure, Unit>> deleteCandidateProject(int projectId);

  // Candidate Educations
  Future<Either<Failure, List<EducationEntity>>> getEducations();

  /// Returns a null entity when the mutation succeeded but the response
  /// payload was incomplete. Callers must refresh from GET in that case.
  Future<Either<Failure, EducationEntity?>> addEducation(
    AddEducationParams params,
  );

  /// Same incomplete-payload contract as [addEducation].
  Future<Either<Failure, EducationEntity?>> updateEducation(
    UpdateEducationParams params,
  );

  Future<Either<Failure, Unit>> deleteEducation(int educationId);

  // Candidate Experiences
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences();

  /// Returns a null entity when the mutation succeeded but the response
  /// payload was incomplete. Callers must refresh from GET in that case.
  Future<Either<Failure, ExperienceEntity?>> addExperience(
    AddExperienceParams params,
  );

  /// Same incomplete-payload contract as [addExperience].
  Future<Either<Failure, ExperienceEntity?>> updateExperience(
    UpdateExperienceParams params,
  );

  Future<Either<Failure, Unit>> deleteExperience(int experienceId);

  // CV Upload
  /// Returns a null receipt when the upload succeeded but the response
  /// carries no usable receipt. Callers must refresh the Main Profile
  /// from GET instead of fabricating document data. Remote-only.
  Future<Either<Failure, CvUploadReceipt?>> uploadCv(CvUploadInput input);

  // Avatar Upload
  /// Uploads the candidate avatar image. Remote-only.
  ///
  /// TODO(avatar-backend): the endpoint, HTTP method, multipart field,
  /// and response schema are pending backend documentation. Nothing
  /// may call this until the contract lands.
  Future<Either<Failure, Unit>> uploadAvatar(AvatarUploadInput input);

  // Career Preferences
  Future<Either<Failure, CareerPreferenceEntity?>> getCareerPreferences();

  Future<Either<Failure, CareerPreferenceEntity>> saveCareerPreferences(
    SaveCareerPreferencesParams params,
  );

  // Candidate Profile Update
  Future<Either<Failure, CandidateProfileEntity>> updateCandidateProfile(
    UpdateCandidateProfileParams params,
  );
}
