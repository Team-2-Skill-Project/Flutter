import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'skill_task_state.dart';

class SkillTaskCubit extends Cubit<SkillTaskState> {
  SkillTaskCubit({required this.sharedPreferencesService})
    : super(const SkillTaskInitial());

  final SharedPreferencesService sharedPreferencesService;

  void loadCompletedTasks() {
    try {
      final tasks = sharedPreferencesService.getCompletedTasks();
      emit(SkillTaskLoaded(completedTaskIds: tasks));
    } catch (e) {
      emit(SkillTaskFailure(errorMessage: e.toString()));
    }
  }

  Future<Set<String>> toggleTaskCompletion({required String taskId}) async {
    final currentTasks = state is SkillTaskLoaded
        ? Set<String>.from((state as SkillTaskLoaded).completedTaskIds)
        : Set<String>.from(sharedPreferencesService.getCompletedTasks());

    if (currentTasks.contains(taskId)) {
      currentTasks.remove(taskId);
    } else {
      currentTasks.add(taskId);
    }

    await sharedPreferencesService.saveCompletedTasks(currentTasks);
    emit(SkillTaskLoaded(completedTaskIds: currentTasks));
    return currentTasks;
  }
}
