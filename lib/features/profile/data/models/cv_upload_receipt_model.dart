import 'package:MatchIn/features/profile/domain/entities/cv_upload_receipt.dart';

class CvUploadReceiptModel extends CvUploadReceipt {
  const CvUploadReceiptModel({required super.id, super.version, super.status});

  /// Parses the `POST /cv/upload` envelope `{message, data:{...}}`.
  /// Returns null when the mutation succeeded (2xx) but no usable
  /// receipt is present (missing/invalid id). Callers must refresh
  /// the Main Profile from GET instead of fabricating document data.
  static CvUploadReceiptModel? tryParseReceipt(dynamic response) {
    if (response is! Map<String, dynamic>) return null;
    final data = response['data'];
    if (data is! Map<String, dynamic>) return null;
    final id = (data['id'] as num?)?.toInt() ?? 0;
    if (id <= 0) return null;
    return CvUploadReceiptModel(
      id: id,
      version: (data['version'] as num?)?.toInt(),
      status: data['status']?.toString(),
    );
  }
}
