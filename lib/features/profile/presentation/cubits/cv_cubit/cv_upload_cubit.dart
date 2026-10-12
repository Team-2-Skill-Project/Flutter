import 'package:MatchIn/features/profile/domain/entities/cv_upload_input.dart';
import 'package:MatchIn/features/profile/domain/use_cases/upload_cv_use_case.dart';
import 'package:MatchIn/features/profile/presentation/cubits/cv_cubit/cv_upload_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CvUploadCubit extends Cubit<CvUploadState> {
  CvUploadCubit({required this.uploadCvUseCase})
    : super(const CvUploadInitial());

  final UploadCvUseCase uploadCvUseCase;

  Future<void> upload(CvUploadInput input) async {
    if (isClosed || state is CvUploading) return;
    emit(const CvUploading());

    final result = await uploadCvUseCase(input);
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(CvUploadFailure(message: failure.message));
      },
      (receipt) {
        emit(CvUploadSuccess(receipt: receipt));
      },
    );
  }
}
