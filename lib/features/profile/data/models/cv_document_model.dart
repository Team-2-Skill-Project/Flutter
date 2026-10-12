import 'package:MatchIn/features/profile/domain/entities/cv_document_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_processing_status.dart';

class CvDocumentModel extends CvDocumentEntity {
  const CvDocumentModel({
    super.id,
    super.fileName,
    super.originalFilename,
    super.fileUrl,
    super.status,
    super.version,
    super.isCurrent,
    super.processedAt,
    super.updatedAt,
    super.failureReason,
  });

  factory CvDocumentModel.fromJson(Map<String, dynamic> json) {
    return CvDocumentModel(
      id: (json['id'] as num?)?.toInt(),
      fileName:
          (json['file_name'] ??
                  json['fileName'] ??
                  json['original_filename'] ??
                  json['originalFilename'] ??
                  json['name'])
              ?.toString(),
      originalFilename: (json['original_filename'] ?? json['originalFilename'])
          ?.toString(),
      // Never treat storage paths as public URLs: only accept
      // explicit file URL keys.
      fileUrl: (json['file_url'] ?? json['fileUrl'] ?? json['url'])?.toString(),
      status: _statusFrom(json['status']?.toString()),
      version: (json['version'] as num?)?.toInt(),
      isCurrent: (json['is_current'] ?? json['isCurrent']) as bool?,
      processedAt: (json['processed_at'] ?? json['processedAt'])?.toString(),
      updatedAt: (json['updated_at'] ?? json['updatedAt'])?.toString(),
      failureReason: (json['failure_reason'] ?? json['failureReason'])
          ?.toString(),
    );
  }

  /// Backend machine string → domain enum. Only documented values
  /// (`processing`, `completed`, `failed`) plus their identical UI
  /// tokens map to known states; everything else is [unknown].
  static CvProcessingStatus? _statusFrom(String? value) {
    if (value == null) return null;
    switch (value.trim().toLowerCase()) {
      case 'processing':
      case 'analyzing':
        return CvProcessingStatus.analyzing;
      case 'completed':
      case 'analyzed':
        return CvProcessingStatus.analyzed;
      case 'failed':
        return CvProcessingStatus.failed;
      default:
        return CvProcessingStatus.unknown;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'original_filename': originalFilename,
      'file_url': fileUrl,
      'status': statusToJson(status),
      'version': version,
      'is_current': isCurrent,
      'processed_at': processedAt,
      'updated_at': updatedAt,
      'failure_reason': failureReason,
    };
  }

  /// Domain enum → canonical backend token for cache round-trips.
  static String? statusToJson(CvProcessingStatus? status) {
    return switch (status) {
      null => null,
      CvProcessingStatus.analyzing => 'processing',
      CvProcessingStatus.analyzed => 'completed',
      CvProcessingStatus.failed => 'failed',
      CvProcessingStatus.unknown => 'unknown',
    };
  }
}
