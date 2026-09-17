import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/features/roadmap/data/models/mockup_roadmap_node.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'roadmap_state.dart';

class RoadmapCubit extends Cubit<RoadmapState> {
  RoadmapCubit({required this.sharedPreferencesService})
    : super(RoadmapInitial());

  final SharedPreferencesService sharedPreferencesService;

  void fetchRoadmapNodes() {
    emit(RoadmapLoading());
    try {
      Set<String>? completedTaskIds;

      final savedTasks = sharedPreferencesService.getCompletedTasks();
      if (savedTasks.isNotEmpty) {
        completedTaskIds = savedTasks;
      }

      // Seed initial completed task IDs if none were saved in storage yet
      final Set<String> activeTaskIds = completedTaskIds ?? {};
      if (completedTaskIds == null) {
        for (final node in roadmapNodes) {
          for (final task in node.tasks) {
            if (task.isCompleted) {
              activeTaskIds.add(task.id);
            }
          }
        }
      }

      final normalized = _normalizeNodes(roadmapNodes, activeTaskIds);

      emit(RoadmapSuccess(nodes: normalized));
    } catch (e) {
      emit(RoadmapFailure(errorMessage: e.toString()));
    }
  }

  void refreshWithCompletedTasks(Set<String> completedTaskIds) {
    final base = state is RoadmapSuccess
        ? (state as RoadmapSuccess).nodes
        : roadmapNodes;
    final normalized = _normalizeNodes(base, completedTaskIds);
    emit(RoadmapSuccess(nodes: normalized));
  }

  List<RoadmapNode> _normalizeNodes(
    List<RoadmapNode> baseNodes,
    Set<String> completedTaskIds,
  ) {
    final List<RoadmapNode> result = [];

    for (int i = 0; i < baseNodes.length; i++) {
      final node = baseNodes[i];

      final updatedTasks = node.tasks.map((task) {
        return task.copyWith(isCompleted: completedTaskIds.contains(task.id));
      }).toList();

      final allTasksCompleted =
          updatedTasks.isNotEmpty && updatedTasks.every((t) => t.isCompleted);

      // Determine node status sequentially
      RoadmapTaskStatus status;
      if (allTasksCompleted) {
        status = RoadmapTaskStatus.completed;
      } else if (i == 0 ||
          (result.isNotEmpty &&
              result[i - 1].status == RoadmapTaskStatus.completed)) {
        status = RoadmapTaskStatus.active;
      } else {
        status = RoadmapTaskStatus.locked;
      }

      result.add(node.copyWith(tasks: updatedTasks, status: status));
    }

    return result;
  }
}
