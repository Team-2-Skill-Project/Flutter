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
      emit(RoadmapSuccess(nodes: roadmapNodes));
    } catch (e) {
      emit(RoadmapFailure(errorMessage: e.toString()));
    }
  }
}
