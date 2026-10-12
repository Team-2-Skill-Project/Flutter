import 'package:MatchIn/features/profile/domain/entities/candidate_profile_entity.dart';
import 'package:equatable/equatable.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

final class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

final class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

final class EditProfileLoadFailure extends EditProfileState {
  const EditProfileLoadFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class EditProfileReady extends EditProfileState {
  const EditProfileReady(this.profile);

  final CandidateProfileEntity profile;

  @override
  List<Object?> get props => [profile];
}

final class EditProfileSaving extends EditProfileState {
  const EditProfileSaving(this.profile);

  final CandidateProfileEntity profile;

  @override
  List<Object?> get props => [profile];
}

final class EditProfileActionFailure extends EditProfileState {
  const EditProfileActionFailure(this.message, {this.profile});

  final String message;
  final CandidateProfileEntity? profile;

  @override
  List<Object?> get props => [message, profile];
}

final class EditProfileSuccess extends EditProfileState {
  const EditProfileSuccess(this.profile);

  final CandidateProfileEntity profile;

  @override
  List<Object?> get props => [profile];
}
