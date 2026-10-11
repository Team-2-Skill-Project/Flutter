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

final class EditProfileReady extends EditProfileState {
  const EditProfileReady(this.profile);

  final CandidateProfileEntity profile;

  @override
  List<Object?> get props => [profile];
}

final class EditProfileSaving extends EditProfileState {
  const EditProfileSaving();
}

final class EditProfileSuccess extends EditProfileState {
  const EditProfileSuccess(this.profile);

  final CandidateProfileEntity profile;

  @override
  List<Object?> get props => [profile];
}

final class EditProfileFailure extends EditProfileState {
  const EditProfileFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
