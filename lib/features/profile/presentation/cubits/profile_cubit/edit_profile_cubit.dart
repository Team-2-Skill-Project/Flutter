import 'package:MatchIn/features/profile/domain/entities/candidate_profile_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/update_candidate_profile_params.dart';
import 'package:MatchIn/features/profile/domain/use_cases/get_candidate_profile_for_edit_use_case.dart';
import 'package:MatchIn/features/profile/domain/use_cases/update_candidate_profile_use_case.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required this._getCandidateProfileForEditUseCase,
    required this._updateCandidateProfileUseCase,
  }) : super(const EditProfileInitial());

  final GetCandidateProfileForEditUseCase _getCandidateProfileForEditUseCase;

  final UpdateCandidateProfileUseCase _updateCandidateProfileUseCase;

  Future<void> loadProfile() async {
    emit(const EditProfileLoading());

    final result = await _getCandidateProfileForEditUseCase();

    result.fold(
      (failure) {
        emit(EditProfileLoadFailure(failure.message));
      },
      (profile) {
        emit(EditProfileReady(profile));
      },
    );
  }

  Future<void> updateProfile(UpdateCandidateProfileParams params) async {
    final currentState = state;
    if (currentState is EditProfileSaving) return;

    final CandidateProfileEntity? baseline = switch (currentState) {
      EditProfileReady(profile: final profile) => profile,
      EditProfileActionFailure(profile: final profile) => profile,
      EditProfileSaving(profile: final profile) => profile,
      _ => null,
    };
    if (baseline == null) return;

    emit(EditProfileSaving(baseline));

    final result = await _updateCandidateProfileUseCase(params);

    result.fold(
      (failure) {
        emit(EditProfileActionFailure(failure.message, profile: baseline));
      },
      (profile) {
        emit(EditProfileSuccess(profile));
      },
    );
  }
}
