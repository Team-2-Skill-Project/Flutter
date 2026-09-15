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
      if (getIt.isRegistered<SharedPreferencesService>()) {
        collectedTreasures =
            getIt<SharedPreferencesService>().getCollectedTreasures();
      }
      emit(RoadmapSuccess(
        nodes: roadmapNodes,
        collectedTreasures: collectedTreasures,
      ));
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
        await getIt<SharedPreferencesService>()
            .saveCollectedTreasures(updatedSet);
      }

      emit(RoadmapSuccess(
        nodes: currentSuccess.nodes,
        collectedTreasures: updatedSet,
      ));
    }
  }
}
