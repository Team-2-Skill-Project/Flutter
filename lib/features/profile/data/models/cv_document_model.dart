import 'package:MatchIn/features/profile/domain/entities/cv_document_entity.dart';

class CvDocumentModel extends CvDocumentEntity {
  const CvDocumentModel({
    super.id,
    super.fileName,
    super.fileUrl,
    super.status,
    super.updatedAt,
  });

  factory CvDocumentModel.fromJson(Map<String, dynamic> json) {
    return CvDocumentModel(
      id: (json['id'] as num?)?.toInt(),
      fileName: (json['file_name'] ?? json['fileName'] ?? json['name'])
          ?.toString(),
      fileUrl: (json['file_url'] ?? json['fileUrl'] ?? json['url'])?.toString(),
      status: json['status']?.toString(),
      updatedAt: (json['updated_at'] ?? json['updatedAt'])?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'file_url': fileUrl,
      'status': status,
      'updated_at': updatedAt,
    };
  }
}
