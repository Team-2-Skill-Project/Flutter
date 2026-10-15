import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_entity.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmaps_params.dart';
import 'package:MatchIn/features/roadmap/domain/use_cases/get_roadmap_details_use_case.dart';
import 'package:MatchIn/features/roadmap/domain/use_cases/get_roadmaps_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'roadmap_state.dart';

/// Remote-only roadmap flow: list → select → details.
///
/// No mock fallback, no local data cache. UI-only XP
/// ([rewardedAdXp]) stays in [SharedPreferencesService].
class RoadmapCubit extends Cubit<RoadmapState> {
  RoadmapCubit({
    required this.sharedPreferencesService,
    required this.getRoadmapsUseCase,
    required this.getRoadmapDetailsUseCase,
  }) : super(RoadmapInitial());

  final SharedPreferencesService sharedPreferencesService;
  final GetRoadmapsUseCase getRoadmapsUseCase;
  final GetRoadmapDetailsUseCase getRoadmapDetailsUseCase;

  List<RoadmapEntity> _cachedRoadmaps = [];
  int _currentPage = 1;
  int _lastPage = 1;
  int _total = 0;
  int? _selectedRoadmapId;
  RoadmapEntity? _lastDetails;
  bool _loadingMore = false;

  /// Roadmaps loaded so far, for the selector sheet.
  List<RoadmapEntity> get cachedRoadmaps =>
      List<RoadmapEntity>.unmodifiable(_cachedRoadmaps);

  int? get selectedRoadmapId => _selectedRoadmapId;

  bool get hasMorePages => _currentPage < _lastPage;

  /// Loads the first page and auto-selects the first roadmap.
  /// Awaits the chained details load so callers observe settled state.
  Future<void> loadRoadmaps() async {
    if (state is RoadmapsLoading) return;
    emit(RoadmapsLoading());

    final result = await getRoadmapsUseCase(params: const RoadmapsParams());
    if (isClosed) return;

    int? autoSelectId;
    result.fold(
      (failure) => emit(RoadmapFailure(errorMessage: failure.message)),
      (page) {
        _cachedRoadmaps = page.roadmaps;
        _currentPage = page.pagination.currentPage;
        _lastPage = page.pagination.lastPage;
        _total = page.pagination.total;
        emit(
          RoadmapsSuccess(
            roadmaps: List<RoadmapEntity>.unmodifiable(_cachedRoadmaps),
            currentPage: _currentPage,
            lastPage: _lastPage,
            total: _total,
          ),
        );
        if (_selectedRoadmapId == null && _cachedRoadmaps.isNotEmpty) {
          autoSelectId = _cachedRoadmaps.first.id;
        }
      },
    );
    final int? selectedId = autoSelectId;
    if (selectedId != null) {
      await selectRoadmap(selectedId);
    }
  }

  /// Appends the next page. Emits [RoadmapsSuccess] so the selector
  /// sheet refreshes, then restores the details view when one is open.
  /// Returns false without emitting when there is nothing to load or
  /// the request fails; cached items are always preserved.
  Future<bool> loadMoreRoadmaps() async {
    if (_loadingMore) return false;
    if (!hasMorePages) return false;
    _loadingMore = true;
    try {
      final result = await getRoadmapsUseCase(
        params: RoadmapsParams(page: _currentPage + 1),
      );
      if (isClosed) return false;
      var appended = false;
      result.fold((_) {}, (page) {
        _cachedRoadmaps = [..._cachedRoadmaps, ...page.roadmaps];
        _currentPage = page.pagination.currentPage;
        _lastPage = page.pagination.lastPage;
        _total = page.pagination.total;
        appended = true;
      });
      if (!appended) return false;
      emit(
        RoadmapsSuccess(
          roadmaps: List<RoadmapEntity>.unmodifiable(_cachedRoadmaps),
          currentPage: _currentPage,
          lastPage: _lastPage,
          total: _total,
        ),
      );
      final lastDetails = _lastDetails;
      if (lastDetails != null) {
        emit(
          RoadmapDetailsSuccess(
            details: lastDetails,
            rewardedAdXp: sharedPreferencesService.getRewardedAdXp(),
          ),
        );
      }
      return true;
    } finally {
      _loadingMore = false;
    }
  }

  /// Selects a roadmap and loads its details.
  Future<void> selectRoadmap(int roadmapId) async {
    _selectedRoadmapId = roadmapId;
    await loadRoadmapDetails(roadmapId);
  }

  /// Loads one roadmap's details with milestones and tasks.
  Future<void> loadRoadmapDetails(int roadmapId) async {
    if (state is RoadmapLoading) return;
    emit(RoadmapLoading());

    final result = await getRoadmapDetailsUseCase(roadmapId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(RoadmapFailure(errorMessage: failure.message)),
      (details) {
        _lastDetails = details;
        emit(
          RoadmapDetailsSuccess(
            details: details,
            rewardedAdXp: sharedPreferencesService.getRewardedAdXp(),
          ),
        );
      },
    );
  }

  /// Retries the current context: details when a roadmap is selected,
  /// otherwise the list.
  Future<void> retry() async {
    final selectedId = _selectedRoadmapId;
    if (selectedId != null) {
      await loadRoadmapDetails(selectedId);
    } else {
      await loadRoadmaps();
    }
  }

  Future<void> addRewardedAdXp(int amount) async {
    try {
      final currentXp = sharedPreferencesService.getRewardedAdXp();
      final updatedXp = currentXp + amount;
      await sharedPreferencesService.saveRewardedAdXp(updatedXp);

      final lastDetails = _lastDetails;
      if (state is RoadmapDetailsSuccess && lastDetails != null) {
        emit(
          RoadmapDetailsSuccess(details: lastDetails, rewardedAdXp: updatedXp),
        );
      } else if (_selectedRoadmapId != null) {
        await loadRoadmapDetails(_selectedRoadmapId!);
      } else {
        await loadRoadmaps();
      }
    } catch (e) {
      emit(RoadmapFailure(errorMessage: e.toString()));
    }
  }
}
