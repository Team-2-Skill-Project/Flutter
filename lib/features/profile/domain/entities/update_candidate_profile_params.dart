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

  static const Object _unset = Object();

  UpdateCandidateProfileParams copyWith({
    Object? dateOfBirth = _unset,
    Object? gender = _unset,
    Object? jobTitle = _unset,
    Object? country = _unset,
    Object? state = _unset,
    Object? city = _unset,
    Object? githubUrl = _unset,
    Object? linkedinUrl = _unset,
    Object? militaryStatus = _unset,
    Object? professionalSummary = _unset,
  }) {
    return UpdateCandidateProfileParams(
      dateOfBirth: identical(dateOfBirth, _unset)
          ? this.dateOfBirth
          : dateOfBirth as String?,
      gender: identical(gender, _unset) ? this.gender : gender as String?,
      jobTitle: identical(jobTitle, _unset)
          ? this.jobTitle
          : jobTitle as String?,
      country: identical(country, _unset) ? this.country : country as String?,
      state: identical(state, _unset) ? this.state : state as String?,
      city: identical(city, _unset) ? this.city : city as String?,
      githubUrl: identical(githubUrl, _unset)
          ? this.githubUrl
          : githubUrl as String?,
      linkedinUrl: identical(linkedinUrl, _unset)
          ? this.linkedinUrl
          : linkedinUrl as String?,
      militaryStatus: identical(militaryStatus, _unset)
          ? this.militaryStatus
          : militaryStatus as String?,
      professionalSummary: identical(professionalSummary, _unset)
          ? this.professionalSummary
          : professionalSummary as String?,
    );
  }

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
