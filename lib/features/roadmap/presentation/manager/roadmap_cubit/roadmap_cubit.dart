import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/features/roadmap/data/models/mockup_roadmap_node.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'roadmap_state.dart';

class RoadmapCubit extends Cubit<RoadmapState> {
  RoadmapCubit() : super(RoadmapInitial());

  void fetchRoadmapNodes() {
    emit(RoadmapLoading());
    try {
      Set<int> collectedTreasures = {};
      Set<String>? completedTaskIds;

      if (getIt.isRegistered<SharedPreferencesService>()) {
        final prefs = getIt<SharedPreferencesService>();
        collectedTreasures = prefs.getCollectedTreasures();
        final savedTasks = prefs.getCompletedTasks();
        if (savedTasks.isNotEmpty) {
          completedTaskIds = savedTasks;
        }
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

      emit(
        RoadmapSuccess(
          nodes: normalized,
          collectedTreasures: collectedTreasures,
        ),
      );
    } catch (e) {
      emit(RoadmapFailure(errorMessage: e.toString()));
    }
  }

  Future<void> claimTreasureReward(int milestoneIndex) async {
    if (state is RoadmapSuccess) {
      final currentSuccess = state as RoadmapSuccess;
      final updatedSet = Set<int>.from(currentSuccess.collectedTreasures)
        ..add(milestoneIndex);

      if (getIt.isRegistered<SharedPreferencesService>()) {
        await getIt<SharedPreferencesService>().saveCollectedTreasures(
          updatedSet,
        );
      }

      emit(
        RoadmapSuccess(
          nodes: currentSuccess.nodes,
          collectedTreasures: updatedSet,
        ),
      );
    }
  }

  Future<void> toggleTaskCompletion({
    required String nodeTitle,
    required String taskId,
  }) async {
    if (state is! RoadmapSuccess) return;
    final currentSuccess = state as RoadmapSuccess;

    // Collect all currently completed task IDs from existing state
    final completedTaskIds = <String>{};
    for (final n in currentSuccess.nodes) {
      for (final t in n.tasks) {
        if (t.isCompleted) {
          completedTaskIds.add(t.id);
        }
      }
    }

    // Toggle target task ID
    if (completedTaskIds.contains(taskId)) {
      completedTaskIds.remove(taskId);
    } else {
      completedTaskIds.add(taskId);
    }

    // Persist updated completed task IDs
    if (getIt.isRegistered<SharedPreferencesService>()) {
      await getIt<SharedPreferencesService>().saveCompletedTasks(
        completedTaskIds,
      );
    }

    // Re-normalize nodes sequentially (marks completed & unlocks next node)
    final normalized = _normalizeNodes(currentSuccess.nodes, completedTaskIds);

    emit(
      RoadmapSuccess(
        nodes: normalized,
        collectedTreasures: currentSuccess.collectedTreasures,
      ),
    );
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
