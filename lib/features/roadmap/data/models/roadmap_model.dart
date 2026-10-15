import 'package:MatchIn/features/roadmap/data/models/roadmap_milestone_model.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_task_model.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_entity.dart';

class RoadmapModel extends RoadmapEntity {
  const RoadmapModel({
    required super.id,
    super.candidateId,
    super.targetRole,
    required super.title,
    super.description,
    super.status,
    super.completionPercentage,
    super.milestones,
    super.createdAt,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    final milestonesJson = json['milestones'];
    final tasksJson = json['tasks'];

    List<RoadmapMilestoneModel> parsedMilestones = const [];
    // --- One malformed milestone must not discard the whole roadmap:
    // --- each entry is parsed independently and skipped on failure. ---
    if (milestonesJson is List) {
      final List<RoadmapMilestoneModel> milestones = [];
      for (final entry in milestonesJson) {
        if (entry is! Map<String, dynamic>) continue;
        try {
          milestones.add(RoadmapMilestoneModel.fromJson(entry));
        } catch (_) {
          continue;
        }
      }
      parsedMilestones = milestones;
    } else if (milestonesJson is Map<String, dynamic>) {
      final List<RoadmapMilestoneModel> milestones = [];
      for (final entry in milestonesJson.values) {
        if (entry is! Map<String, dynamic>) continue;
        try {
          milestones.add(RoadmapMilestoneModel.fromJson(entry));
        } catch (_) {
          continue;
        }
      }
      parsedMilestones = milestones;
    } else if (tasksJson is List) {
      // If the backend returns flat tasks on data, wrap them in a default milestone
      final List<RoadmapTaskModel> tasks = tasksJson
          .whereType<Map<String, dynamic>>()
          .where((item) => _parseId(item['id']) != null)
          .map(RoadmapTaskModel.fromJson)
          .toList();
      if (tasks.isNotEmpty) {
        parsedMilestones = [
          RoadmapMilestoneModel(
            id: 1,
            roadmapId: _parseId(json['id']) ?? 0,
            title: json['title']?.toString() ?? 'Tasks',
            order: 1,
            tasks: tasks,
          ),
        ];
      }
    }

    final double completion =
        (json['completion_percentage'] as num?)?.toDouble() ??
        double.tryParse(json['completion_percentage']?.toString() ?? '') ??
        0.0;

    return RoadmapModel(
      id: _parseId(json['id']) ?? 0,
      candidateId: _parseId(json['candidate_id']),
      targetRole: json['target_role']?.toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      status: json['status']?.toString(),
      completionPercentage: completion,
      milestones: parsedMilestones,
      createdAt: json['created_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (candidateId != null) 'candidate_id': candidateId,
      if (targetRole != null) 'target_role': targetRole,
      'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      'completion_percentage': completionPercentage,
      'milestones': milestones.map((m) {
        if (m is RoadmapMilestoneModel) return m.toJson();
        return RoadmapMilestoneModel(
          id: m.id,
          roadmapId: m.roadmapId,
          title: m.title,
          order: m.order,
          tasks: m.tasks,
        ).toJson();
      }).toList(),
      if (createdAt != null) 'created_at': createdAt,
    };
  }

  static int? _parseId(dynamic value) {
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim());
    return null;
  }
}
