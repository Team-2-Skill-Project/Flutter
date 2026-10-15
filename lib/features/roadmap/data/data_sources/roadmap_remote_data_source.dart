import 'package:MatchIn/features/roadmap/data/models/roadmap_model.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_pagination_model.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmaps_params.dart';

abstract class RoadmapRemoteDataSource {
  Future<({List<RoadmapModel> roadmaps, RoadmapPaginationModel pagination})>
  getRoadmaps({RoadmapsParams? params});

  Future<RoadmapModel> getRoadmapDetails(int roadmapId);
}
