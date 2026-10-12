import 'dart:typed_data';

import 'package:MatchIn/core/errors/failures.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_upload_input.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_upload_receipt.dart';
import 'package:MatchIn/features/profile/domain/repositories/profile_repository.dart';
import 'package:MatchIn/features/profile/domain/use_cases/upload_cv_use_case.dart';
import 'package:MatchIn/features/profile/presentation/cubits/cv_cubit/cv_upload_cubit.dart';
import 'package:MatchIn/features/profile/presentation/cubits/cv_cubit/cv_upload_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCvRepository extends Fake implements ProfileRepository {
  Either<Failure, CvUploadReceipt?>? uploadResult;

  @override
  Future<Either<Failure, CvUploadReceipt?>> uploadCv(
    CvUploadInput input,
  ) async {
    return uploadResult!;
  }
}

CvUploadInput testInput() => CvUploadInput(
  fileName: 'cv.pdf',
  extension: 'pdf',
  sizeBytes: 3,
  bytes: Uint8List.fromList([1, 2, 3]),
);

const _receipt = CvUploadReceipt(id: 2, version: 2, status: 'processing');

CvUploadCubit buildCubit(FakeCvRepository repo) =>
    CvUploadCubit(uploadCvUseCase: UploadCvUseCase(repository: repo));

void main() {
  late FakeCvRepository repo;

  setUp(() {
    repo = FakeCvRepository();
  });

  group('CvUploadCubit', () {
    blocTest<CvUploadCubit, CvUploadState>(
      'emits [Uploading, Success] on upload success',
      build: () {
        repo.uploadResult = const Right(_receipt);
        return buildCubit(repo);
      },
      act: (cubit) => cubit.upload(testInput()),
      expect: () => const [CvUploading(), CvUploadSuccess(receipt: _receipt)],
    );

    blocTest<CvUploadCubit, CvUploadState>(
      'emits Success with null receipt when the payload is incomplete',
      build: () {
        repo.uploadResult = const Right(null);
        return buildCubit(repo);
      },
      act: (cubit) => cubit.upload(testInput()),
      expect: () => const [CvUploading(), CvUploadSuccess(receipt: null)],
    );

    blocTest<CvUploadCubit, CvUploadState>(
      'emits [Uploading, Failure] on upload failure',
      build: () {
        repo.uploadResult = const Left(ServerFailure(message: 'Upload failed'));
        return buildCubit(repo);
      },
      act: (cubit) => cubit.upload(testInput()),
      expect: () => const [
        CvUploading(),
        CvUploadFailure(message: 'Upload failed'),
      ],
    );

    blocTest<CvUploadCubit, CvUploadState>(
      'emits [Uploading, Failure] when offline',
      build: () {
        repo.uploadResult = const Left(OfflineFailure());
        return buildCubit(repo);
      },
      act: (cubit) => cubit.upload(testInput()),
      expect: () => const [
        CvUploading(),
        CvUploadFailure(message: 'You are offline'),
      ],
    );

    blocTest<CvUploadCubit, CvUploadState>(
      'prevents duplicate upload requests',
      build: () {
        repo.uploadResult = const Right(_receipt);
        return buildCubit(repo);
      },
      seed: () => const CvUploading(),
      act: (cubit) => cubit.upload(testInput()),
      expect: () => isEmpty,
    );

    test('does nothing harmful when closed during upload', () async {
      repo.uploadResult = const Right(_receipt);
      final cubit = buildCubit(repo);
      await cubit.close();
      await cubit.upload(testInput());
      expect(cubit.state, const CvUploadInitial());
      await cubit.close();
    });
  });
}
