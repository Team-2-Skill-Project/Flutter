import 'package:MatchIn/core/networking/api_consumer.dart';
import 'package:MatchIn/core/networking/api_end_points.dart';
import 'package:MatchIn/features/roadmap/data/data_sources/roadmap_remote_data_source.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_model.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_pagination_model.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmaps_params.dart';

class RoadmapRemoteDataSourceImpl implements RoadmapRemoteDataSource {
  RoadmapRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<({List<RoadmapModel> roadmaps, RoadmapPaginationModel pagination})>
  getRoadmaps({RoadmapsParams? params}) async {
    final effectiveParams = params ?? const RoadmapsParams();
    final response = await apiConsumer.get(
      EndPoint.roadmaps,
      queryParameters: effectiveParams.toJson(),
    );

    if (response is! Map<String, dynamic>) {
      throw const FormatException('Invalid roadmaps response format');
    }

    final data = response['data'];
    if (data is! List) {
      throw const FormatException('Invalid roadmaps data format');
    }

    final meta = response['meta'];
    if (meta is! Map<String, dynamic>) {
      throw const FormatException('Invalid roadmaps pagination format');
    }

    final roadmaps = data
        .whereType<Map<String, dynamic>>()
        .map(RoadmapModel.fromJson)
        .toList();
    return (
      roadmaps: roadmaps,
      pagination: RoadmapPaginationModel.fromJson(meta),
    );
  }

  @override
  Future<RoadmapModel> getRoadmapDetails(int roadmapId) async {
    final response = await apiConsumer.get(EndPoint.roadmapDetails(roadmapId));

    if (response is! Map<String, dynamic>) {
      throw const FormatException('Invalid roadmap details response format');
    }

    final data = response['data'];
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid roadmap details data format');
    }

    return RoadmapModel.fromJson(data);
  }
}
