import 'package:MatchIn/features/profile/domain/entities/candidate_project_entity.dart';

class CandidateProjectModel extends CandidateProjectEntity {
  const CandidateProjectModel({
    required super.id,
    required super.name,
    required super.technologies,
    required super.source,
    super.description,
    super.projectUrl,
    super.githubUrl,
    super.startDate,
    super.endDate,
  });

  factory CandidateProjectModel.fromJson(Map<String, dynamic> json) {
    return CandidateProjectModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      technologies:
          (json['technologies'] as List<dynamic>?)
              ?.map((technology) => technology.toString())
              .toList() ??
          const [],
      projectUrl: json['project_url'] as String?,
      githubUrl: json['github_url'] as String?,
      source: json['source'] as String? ?? 'manual',
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'technologies': technologies,
      'project_url': projectUrl,
      'github_url': githubUrl,
      'source': source,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  /// Strict parser for POST/PATCH mutation responses.
  ///
  /// Returns null when the payload is not a complete record: an
  /// invalid `id` or a blank `name` (required on create, so always
  /// present in a complete object). Callers must treat null as
  /// "mutation accepted but payload unusable" and refresh from GET
  /// instead of replacing list data with defaults.
  static CandidateProjectModel? tryParseMutation(Map<String, dynamic> json) {
    final id = (json['id'] as num?)?.toInt() ?? 0;
    if (id <= 0) return null;

    final name = json['name']?.toString().trim() ?? '';
    if (name.isEmpty) return null;

    return CandidateProjectModel.fromJson(json);
  }
}
