part of 'roadmap_cubit.dart';

@immutable
sealed class RoadmapState {}

final class RoadmapInitial extends RoadmapState {}

/// Roadmap details loading (initial selection, selection change, retry).
final class RoadmapLoading extends RoadmapState {}

/// Roadmap list loading (first page, retry).
final class RoadmapsLoading extends RoadmapState {}

/// Paginated roadmap list. The node path is NOT rendered from this
/// state: after the first load the cubit chains into details loading
/// for the selected roadmap. The selector sheet reads this state to
/// refresh its rows after Load More.
final class RoadmapsSuccess extends RoadmapState {
  RoadmapsSuccess({
    required this.roadmaps,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<RoadmapEntity> roadmaps;
  final int currentPage;
  final int lastPage;
  final int total;
}

/// Selected roadmap details. The node path maps [details] to visual
/// nodes in the view layer.
final class RoadmapDetailsSuccess extends RoadmapState {
  RoadmapDetailsSuccess({required this.details, this.rewardedAdXp = 0});

  final RoadmapEntity details;
  final int rewardedAdXp;
}

final class RoadmapFailure extends RoadmapState {
  RoadmapFailure({required this.errorMessage});

  final String errorMessage;
}
