import 'package:MatchIn/features/profile/domain/entities/cv_upload_receipt.dart';
import 'package:equatable/equatable.dart';

sealed class CvUploadState extends Equatable {
  const CvUploadState();

  @override
  List<Object?> get props => [];
}

final class CvUploadInitial extends CvUploadState {
  const CvUploadInitial();
}

final class CvUploading extends CvUploadState {
  const CvUploading();
}

final class CvUploadSuccess extends CvUploadState {
  const CvUploadSuccess({this.receipt});

  /// Null when the upload succeeded but the response carried no
  /// usable receipt. The Main Profile still refreshes from GET.
  final CvUploadReceipt? receipt;

  @override
  List<Object?> get props => [receipt];
}

final class CvUploadFailure extends CvUploadState {
  const CvUploadFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
