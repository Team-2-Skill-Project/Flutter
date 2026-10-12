import 'dart:typed_data';

import 'package:MatchIn/core/errors/failures.dart';
import 'package:MatchIn/core/services/file_picker_service.dart';
import 'package:MatchIn/core/services/picked_file.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_profile_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_document_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_processing_status.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_upload_input.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_upload_receipt.dart';
import 'package:MatchIn/features/profile/domain/entities/profile_user_entity.dart';
import 'package:MatchIn/features/profile/domain/repositories/profile_repository.dart';
import 'package:MatchIn/features/profile/domain/use_cases/get_cached_candidate_profile_use_case.dart';
import 'package:MatchIn/features/profile/domain/use_cases/get_candidate_profile_use_case.dart';
import 'package:MatchIn/features/profile/domain/use_cases/upload_cv_use_case.dart';
import 'package:MatchIn/features/profile/presentation/cubits/cv_cubit/cv_upload_cubit.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/cv_widgets/cv_profile_section.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSectionRepository extends Fake implements ProfileRepository {
  Either<Failure, CandidateProfileEntity>? profileResult;
  Either<Failure, CvUploadReceipt?>? uploadResult;
  int profileCalls = 0;

  @override
  Future<Either<Failure, CandidateProfileEntity>> getCandidateProfile() async {
    profileCalls++;
    return profileResult!;
  }

  @override
  Future<Either<Failure, CvUploadReceipt?>> uploadCv(
    CvUploadInput input,
  ) async {
    return uploadResult!;
  }
}

class FakePicker implements FilePickerService {
  PickedFile? fileToReturn;

  @override
  Future<PlatformFile?> pickCv() async {
    throw UnimplementedError();
  }

  @override
  Future<PickedFile?> pickCvBytes() async {
    return fileToReturn;
  }
}

const _user = ProfileUserEntity(
  id: 1,
  name: 'Ahmed',
  email: 'ahmed@example.com',
  role: 'candidate',
  isActive: true,
);

CandidateProfileEntity profileWithCv() => const CandidateProfileEntity(
  profileExists: true,
  user: _user,
  cvDocument: CvDocumentEntity(
    id: 9,
    fileName: 'new-cv.pdf',
    status: CvProcessingStatus.analyzed,
  ),
);

PickedFile pdfFile() =>
    PickedFile(name: 'my-cv.pdf', bytes: Uint8List.fromList([1, 2, 3, 4]));

Future<void> pumpSection(
  WidgetTester tester, {
  required FakeSectionRepository repo,
  CvDocumentEntity? cvDocument,
}) async {
  tester.view.physicalSize = const Size(1170, 2535);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  getIt.registerFactory<CvUploadCubit>(
    () => CvUploadCubit(uploadCvUseCase: UploadCvUseCase(repository: repo)),
  );

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 845),
      builder: (_, _) => MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: BlocProvider<ProfileCubit>(
            create: (_) => ProfileCubit(
              getCandidateProfileUseCase: GetCandidateProfileUseCase(
                repository: repo,
              ),
              getCachedCandidateProfileUseCase:
                  GetCachedCandidateProfileUseCase(repository: repo),
            ),
            child: CvProfileSection(cvDocument: cvDocument),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late FakeSectionRepository repo;
  late FakePicker picker;

  setUp(() {
    repo = FakeSectionRepository();
    picker = FakePicker();
    getIt.registerSingleton<FilePickerService>(picker);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('CvProfileSection upload', () {
    testWidgets('upload success shows feedback and refreshes Main Profile', (
      tester,
    ) async {
      picker.fileToReturn = pdfFile();
      repo.uploadResult = const Right(
        CvUploadReceipt(id: 2, version: 2, status: 'processing'),
      );
      repo.profileResult = Right(profileWithCv());
      await pumpSection(tester, repo: repo);

      await tester.tap(find.text('Choose File'));
      await tester.pumpAndSettle();

      expect(find.text('CV uploaded successfully'), findsOneWidget);
      expect(repo.profileCalls, 1);
    });

    testWidgets('upload failure shows feedback and preserves the old CV', (
      tester,
    ) async {
      picker.fileToReturn = pdfFile();
      repo.uploadResult = const Left(ServerFailure(message: 'Upload failed'));
      const existing = CvDocumentEntity(
        id: 1,
        fileName: 'old-cv.pdf',
        status: CvProcessingStatus.analyzed,
      );
      await pumpSection(tester, repo: repo, cvDocument: existing);

      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Upload failed'), findsOneWidget);
      expect(find.text('old-cv.pdf'), findsOneWidget);
      expect(repo.profileCalls, 0);
    });

    testWidgets('refresh failure after upload shows refresh feedback', (
      tester,
    ) async {
      picker.fileToReturn = pdfFile();
      repo.uploadResult = const Right(
        CvUploadReceipt(id: 2, version: 2, status: 'processing'),
      );
      repo.profileResult = const Left(ServerFailure(message: 'Down'));
      await pumpSection(tester, repo: repo);

      await tester.tap(find.text('Choose File'));
      await tester.pumpAndSettle();

      expect(
        find.text('CV uploaded, but the profile could not be refreshed.'),
        findsOneWidget,
      );
    });
  });

  group('CvProfileSection view', () {
    testWidgets('view without a usable URL shows failure feedback', (
      tester,
    ) async {
      const existing = CvDocumentEntity(
        id: 1,
        fileName: 'old-cv.pdf',
        status: CvProcessingStatus.analyzed,
      );
      await pumpSection(tester, repo: repo, cvDocument: existing);

      await tester.tap(find.text('View CV'));
      await tester.pumpAndSettle();

      expect(find.text('Could not open the CV document.'), findsOneWidget);
    });
  });
}
