import 'package:MatchIn/core/errors/exceptions.dart';
import 'package:MatchIn/core/errors/failures.dart';
import 'package:MatchIn/core/networking/network_info.dart';
import 'package:MatchIn/features/roadmap/data/data_sources/roadmap_remote_data_source.dart';
import 'package:MatchIn/features/roadmap/domain/entities/paginated_roadmaps_entity.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_entity.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmaps_params.dart';
import 'package:MatchIn/features/roadmap/domain/repositories/roadmap_repository.dart';
import 'package:dartz/dartz.dart';

/// Remote-only repository: no local cache. Offline yields
/// [OfflineFailure]; API failures surface without stale fallback.
class RoadmapRepositoryImpl implements RoadmapRepository {
  const RoadmapRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final RoadmapRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, PaginatedRoadmapsEntity>> getRoadmaps({
    RoadmapsParams? params,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(OfflineFailure());
    }

    try {
      final result = await remoteDataSource.getRoadmaps(params: params);

      return Right(
        PaginatedRoadmapsEntity(
          roadmaps: result.roadmaps,
          pagination: result.pagination.toEntity(),
        ),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.errorModel.errorMessage,
          fieldErrors: e.errorModel.fieldErrors,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RoadmapEntity>> getRoadmapDetails(
    int roadmapId,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(OfflineFailure());
    }

    try {
      final roadmap = await remoteDataSource.getRoadmapDetails(roadmapId);

      return Right(roadmap);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.errorModel.errorMessage,
          fieldErrors: e.errorModel.fieldErrors,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
