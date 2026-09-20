part of 'skill_task_cubit.dart';

@immutable
sealed class SkillTaskState {
  const SkillTaskState();
}

final class SkillTaskInitial extends SkillTaskState {
  const SkillTaskInitial();
}

final class SkillTaskLoaded extends SkillTaskState {
  const SkillTaskLoaded({this.completedTaskIds = const {}});

  final Set<String> completedTaskIds;
}

final class SkillTaskFailure extends SkillTaskState {
  const SkillTaskFailure({required this.errorMessage});

  final String errorMessage;
}
