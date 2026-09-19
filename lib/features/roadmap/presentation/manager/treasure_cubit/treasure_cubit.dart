import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'treasure_state.dart';

class TreasureCubit extends Cubit<TreasureState> {
  TreasureCubit({required this.sharedPreferencesService})
    : super(const TreasureInitial());

  final SharedPreferencesService sharedPreferencesService;

  void loadCollectedTreasures() {
    try {
      final collected = sharedPreferencesService.getCollectedTreasures();
      emit(TreasureLoaded(collectedTreasures: collected));
    } catch (e) {
      emit(TreasureFailure(errorMessage: e.toString()));
    }
  }

  Future<void> claimTreasureReward(int milestoneIndex) async {
    final currentCollected = state is TreasureLoaded
        ? (state as TreasureLoaded).collectedTreasures
        : <int>{};
    final updatedSet = Set<int>.from(currentCollected)..add(milestoneIndex);
    await sharedPreferencesService.saveCollectedTreasures(updatedSet);
    emit(TreasureLoaded(collectedTreasures: updatedSet));
  }
}
