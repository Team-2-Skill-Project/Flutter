import 'package:equatable/equatable.dart';

class CvDocumentEntity extends Equatable {
  const CvDocumentEntity({
    this.id,
    this.fileName,
    this.fileUrl,
    this.status,
    this.updatedAt,
  });

  final int? id;
  final String? fileName;
  final String? fileUrl;
  final String? status;
  final String? updatedAt;

  @override
  List<Object?> get props => [id, fileName, fileUrl, status, updatedAt];
}
