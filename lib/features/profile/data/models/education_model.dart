import 'package:MatchIn/features/profile/domain/entities/education_entity.dart';

class EducationModel extends EducationEntity {
  const EducationModel({
    required super.id,
    required super.degree,
    required super.institution,
    super.startDate,
    super.endDate,
    super.grade,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      degree:
          (json['degree'] ?? json['degree_name'] ?? json['title'])
              ?.toString() ??
          '',
      institution:
          (json['institution'] ??
                  json['school'] ??
                  json['university'] ??
                  json['university_name'])
              ?.toString() ??
          '',
      startDate: (json['start_date'] ?? json['startDate'])?.toString(),
      endDate: (json['end_date'] ?? json['endDate'])?.toString(),
      grade: json['grade']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'degree': degree,
      'institution': institution,
      'start_date': startDate,
      'end_date': endDate,
      'grade': grade,
    };
  }
}
