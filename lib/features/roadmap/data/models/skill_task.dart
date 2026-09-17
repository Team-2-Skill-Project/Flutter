enum TaskResourceType {
  youtube,
  documentation,
  github,
  article,
  course,
  quiz,
}

extension TaskResourceTypeExtension on TaskResourceType {
  String get displayName {
    switch (this) {
      case TaskResourceType.youtube:
        return 'YouTube';
      case TaskResourceType.documentation:
        return 'Docs';
      case TaskResourceType.github:
        return 'GitHub';
      case TaskResourceType.article:
        return 'Article';
      case TaskResourceType.course:
        return 'Course';
      case TaskResourceType.quiz:
        return 'Quiz';
    }
  }
}

class TaskResource {
  const TaskResource({
    required this.type,
    required this.title,
    required this.url,
  });

  final TaskResourceType type;
  final String title;
  final String url;
}

class SkillTask {
  const SkillTask({
    required this.id,
    required this.title,
    this.description,
    required this.duration,
    this.isCompleted = false,
    this.resources = const [],
  });

  final String id;
  final String title;
  final String? description;
  final String duration;
  final bool isCompleted;
  final List<TaskResource> resources;

  SkillTask copyWith({
    String? id,
    String? title,
    String? description,
    String? duration,
    bool? isCompleted,
    List<TaskResource>? resources,
  }) {
    return SkillTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
      resources: resources ?? this.resources,
    );
  }
}
