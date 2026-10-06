import 'package:equatable/equatable.dart';

class UpdateCandidateProfileParams extends Equatable {
  const UpdateCandidateProfileParams({
    this.dateOfBirth,
    this.gender,
    this.jobTitle,
    this.country,
    this.state,
    this.city,
    this.githubUrl,
    this.linkedinUrl,
    this.militaryStatus,
    this.professionalSummary,
  });

  final String? dateOfBirth;
  final String? gender;
  final String? jobTitle;
  final String? country;
  final String? state;
  final String? city;
  final String? githubUrl;
  final String? linkedinUrl;
  final String? militaryStatus;
  final String? professionalSummary;

  @override
  List<Object?> get props => [
    dateOfBirth,
    gender,
    jobTitle,
    country,
    state,
    city,
    githubUrl,
    linkedinUrl,
    militaryStatus,
    professionalSummary,
  ];
}
