import 'package:MatchIn/core/errors/failures.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_profile_details_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_profile_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/profile_user_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/update_candidate_profile_params.dart';
import 'package:MatchIn/features/profile/domain/repositories/profile_repository.dart';
import 'package:MatchIn/features/profile/domain/use_cases/get_candidate_profile_for_edit_use_case.dart';
import 'package:MatchIn/features/profile/domain/use_cases/update_candidate_profile_use_case.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/edit_profile_cubit.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/edit_profile_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeEditProfileRepository extends Fake implements ProfileRepository {
  Either<Failure, CandidateProfileEntity>? loadResult;
  Either<Failure, CandidateProfileEntity>? updateResult;
  UpdateCandidateProfileParams? lastParams;

  @override
  Future<Either<Failure, CandidateProfileEntity>>
  getCandidateProfileForEdit() async {
    return loadResult!;
  }

  @override
  Future<Either<Failure, CandidateProfileEntity>> updateCandidateProfile(
    UpdateCandidateProfileParams params,
  ) async {
    lastParams = params;
    return updateResult!;
  }
}

CandidateProfileEntity makeProfile({String jobTitle = 'Junior Developer'}) =>
    CandidateProfileEntity(
      profileExists: true,
      user: const ProfileUserEntity(
        id: 1,
        name: 'Ahmed Mohamed',
        email: 'ahmed@example.com',
        role: 'candidate',
        isActive: true,
      ),
      profile: CandidateProfileDetailsEntity(
        id: 3,
        jobTitle: jobTitle,
        country: 'Egypt',
        city: 'Cairo',
      ),
    );

EditProfileCubit buildCubit(FakeEditProfileRepository repo) => EditProfileCubit(
  getCandidateProfileForEditUseCase: GetCandidateProfileForEditUseCase(repo),
  updateCandidateProfileUseCase: UpdateCandidateProfileUseCase(repo),
);

void main() {
  late FakeEditProfileRepository repo;

  setUp(() {
    repo = FakeEditProfileRepository();
  });

  group('EditProfileCubit load', () {
    blocTest<EditProfileCubit, EditProfileState>(
      'emits [Loading, Ready] when remote load succeeds',
      build: () {
        repo.loadResult = Right(makeProfile());
        return buildCubit(repo);
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const EditProfileLoading(),
        EditProfileReady(makeProfile()),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits [Loading, LoadFailure] when offline',
      build: () {
        repo.loadResult = const Left(OfflineFailure());
        return buildCubit(repo);
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => const [
        EditProfileLoading(),
        EditProfileLoadFailure('You are offline'),
      ],
    );
  });

  group('EditProfileCubit save', () {
    blocTest<EditProfileCubit, EditProfileState>(
      'emits [Saving, Success] on successful PATCH',
      build: () {
        repo.updateResult = Right(makeProfile(jobTitle: 'Senior Developer'));
        return buildCubit(repo);
      },
      seed: () => EditProfileReady(makeProfile()),
      act: (cubit) => cubit.updateProfile(
        const UpdateCandidateProfileParams().copyWith(
          jobTitle: 'Senior Developer',
        ),
      ),
      expect: () => [
        EditProfileSaving(makeProfile()),
        EditProfileSuccess(makeProfile(jobTitle: 'Senior Developer')),
      ],
      verify: (_) {
        expect(repo.lastParams?.hasChanges, isTrue);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits [Saving, ActionFailure] with baseline preserved on save failure',
      build: () {
        repo.updateResult = const Left(
          ServerFailure(message: 'Validation failed'),
        );
        return buildCubit(repo);
      },
      seed: () => EditProfileReady(makeProfile()),
      act: (cubit) => cubit.updateProfile(
        const UpdateCandidateProfileParams().copyWith(
          jobTitle: 'Senior Developer',
        ),
      ),
      expect: () => [
        EditProfileSaving(makeProfile()),
        EditProfileActionFailure('Validation failed', profile: makeProfile()),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'allows retry after action failure without losing baseline',
      build: () {
        repo.updateResult = Right(makeProfile(jobTitle: 'Senior Developer'));
        return buildCubit(repo);
      },
      seed: () =>
          EditProfileActionFailure('Validation failed', profile: makeProfile()),
      act: (cubit) => cubit.updateProfile(
        const UpdateCandidateProfileParams().copyWith(
          jobTitle: 'Senior Developer',
        ),
      ),
      expect: () => [
        EditProfileSaving(makeProfile()),
        EditProfileSuccess(makeProfile(jobTitle: 'Senior Developer')),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'does nothing when saving without a loaded baseline',
      build: () => buildCubit(repo),
      act: (cubit) => cubit.updateProfile(
        const UpdateCandidateProfileParams().copyWith(
          jobTitle: 'Senior Developer',
        ),
      ),
      expect: () => isEmpty,
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'does nothing when params carry no changes (empty PATCH prevention)',
      build: () => buildCubit(repo),
      seed: () => EditProfileReady(makeProfile()),
      act: (cubit) => cubit.updateProfile(const UpdateCandidateProfileParams()),
      expect: () => isEmpty,
      verify: (_) {
        expect(repo.lastParams, isNull);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'ignores a second save while already saving',
      build: () {
        repo.updateResult = Right(makeProfile(jobTitle: 'Senior Developer'));
        return buildCubit(repo);
      },
      seed: () => EditProfileSaving(makeProfile()),
      act: (cubit) => cubit.updateProfile(
        const UpdateCandidateProfileParams().copyWith(
          jobTitle: 'Senior Developer',
        ),
      ),
      expect: () => isEmpty,
    );
  });
}
