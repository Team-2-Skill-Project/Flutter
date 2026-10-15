import 'package:MatchIn/core/cache/shared_preferences_helper.dart';
import 'package:MatchIn/core/errors/failures.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/features/roadmap/domain/entities/paginated_roadmaps_entity.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_entity.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_milestone.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_pagination_entity.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_task.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmaps_params.dart';
import 'package:MatchIn/features/roadmap/domain/repositories/roadmap_repository.dart';
import 'package:MatchIn/features/roadmap/domain/use_cases/get_roadmap_details_use_case.dart';
import 'package:MatchIn/features/roadmap/domain/use_cases/get_roadmaps_use_case.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/skill_task_cubit/skill_task_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/treasure_cubit/treasure_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeRoadmapRepository extends Fake implements RoadmapRepository {
  Either<Failure, PaginatedRoadmapsEntity>? listResult;
  Either<Failure, RoadmapEntity>? detailsResult;
  int listCalls = 0;
  int detailsCalls = 0;

  @override
  Future<Either<Failure, PaginatedRoadmapsEntity>> getRoadmaps({
    RoadmapsParams? params,
  }) async {
    listCalls++;
    return listResult!;
  }

  @override
  Future<Either<Failure, RoadmapEntity>> getRoadmapDetails(
    int roadmapId,
  ) async {
    detailsCalls++;
    return detailsResult!;
  }
}

const _page1 = PaginatedRoadmapsEntity(
  roadmaps: [
    RoadmapEntity(
      id: 1,
      title: 'Cloud Architect',
      targetRole: 'Cloud Architect',
    ),
    RoadmapEntity(id: 2, title: 'Backend Pro', targetRole: 'Backend'),
  ],
  pagination: RoadmapPaginationEntity(
    currentPage: 1,
    lastPage: 2,
    perPage: 15,
    total: 3,
  ),
);

const _details = RoadmapEntity(
  id: 1,
  title: 'Cloud Architect',
  milestones: [
    RoadmapMilestone(
      id: 1,
      title: 'Containers',
      order: 1,
      tasks: [RoadmapTask(id: 1, title: 'Docker lab', isCompleted: true)],
    ),
  ],
);

RoadmapCubit buildRoadmapCubit(
  SharedPreferencesService prefs,
  FakeRoadmapRepository repo,
) => RoadmapCubit(
  sharedPreferencesService: prefs,
  getRoadmapsUseCase: GetRoadmapsUseCase(repository: repo),
  getRoadmapDetailsUseCase: GetRoadmapDetailsUseCase(repository: repo),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesService sharedPreferencesService;
  late TreasureCubit treasureCubit;
  late SkillTaskCubit skillTaskCubit;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final helper = SharedPreferencesHelper(preferences: prefs);
    sharedPreferencesService = SharedPreferencesService(helper);

    treasureCubit = TreasureCubit(
      sharedPreferencesService: sharedPreferencesService,
    );
    skillTaskCubit = SkillTaskCubit(
      sharedPreferencesService: sharedPreferencesService,
    );
  });

  group('Roadmap Features Cubit Unit Tests', () {
    test('RoadmapCubit loads list then auto-selects first details', () async {
      final repo = FakeRoadmapRepository()
        ..listResult = const Right(_page1)
        ..detailsResult = const Right(_details);
      final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

      await cubit.loadRoadmaps();

      expect(cubit.state, isA<RoadmapDetailsSuccess>());
      final state = cubit.state as RoadmapDetailsSuccess;
      expect(state.details.id, 1);
      expect(repo.listCalls, 1);
      expect(repo.detailsCalls, 1);
      await cubit.close();
    });

    test('RoadmapCubit shows empty state without details call', () async {
      final repo = FakeRoadmapRepository()
        ..listResult = const Right(
          PaginatedRoadmapsEntity(
            roadmaps: [],
            pagination: RoadmapPaginationEntity(
              currentPage: 1,
              lastPage: 1,
              perPage: 15,
              total: 0,
            ),
          ),
        );
      final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

      await cubit.loadRoadmaps();

      expect(cubit.state, isA<RoadmapsSuccess>());
      expect((cubit.state as RoadmapsSuccess).roadmaps, isEmpty);
      expect(repo.detailsCalls, 0);
      await cubit.close();
    });

    test('RoadmapCubit emits failure on list error', () async {
      final repo = FakeRoadmapRepository()
        ..listResult = const Left(ServerFailure(message: 'Down'));
      final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

      await cubit.loadRoadmaps();

      expect(cubit.state, isA<RoadmapFailure>());
      await cubit.close();
    });

    test('RoadmapCubit emits failure on offline list load', () async {
      final repo = FakeRoadmapRepository()
        ..listResult = const Left(OfflineFailure());
      final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

      await cubit.loadRoadmaps();

      expect(cubit.state, isA<RoadmapFailure>());
      await cubit.close();
    });

    test('RoadmapCubit loadMore appends and restores details', () async {
      const page2 = PaginatedRoadmapsEntity(
        roadmaps: [RoadmapEntity(id: 3, title: 'Mobile Pro')],
        pagination: RoadmapPaginationEntity(
          currentPage: 2,
          lastPage: 2,
          perPage: 15,
          total: 3,
        ),
      );
      final repo = FakeRoadmapRepository()
        ..listResult = const Right(_page1)
        ..detailsResult = const Right(_details);
      final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

      await cubit.loadRoadmaps();
      repo.listResult = const Right(page2);
      final ok = await cubit.loadMoreRoadmaps();

      expect(ok, isTrue);
      expect(cubit.cachedRoadmaps.length, 3);
      expect(cubit.state, isA<RoadmapDetailsSuccess>());
      await cubit.close();
    });

    test('RoadmapCubit loadMore returns false without more pages', () async {
      final repo = FakeRoadmapRepository()
        ..listResult = const Right(_page1)
        ..detailsResult = const Right(_details);
      final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

      await cubit.loadRoadmaps();
      expect(cubit.hasMorePages, isTrue);

      repo.listResult = const Right(
        PaginatedRoadmapsEntity(
          roadmaps: [],
          pagination: RoadmapPaginationEntity(
            currentPage: 2,
            lastPage: 2,
            perPage: 15,
            total: 3,
          ),
        ),
      );
      await cubit.loadMoreRoadmaps();
      expect(cubit.hasMorePages, isFalse);

      final calls = repo.listCalls;
      expect(await cubit.loadMoreRoadmaps(), isFalse);
      expect(repo.listCalls, calls);
      await cubit.close();
    });

    test('RoadmapCubit retry reloads details when selected', () async {
      final repo = FakeRoadmapRepository()
        ..listResult = const Right(_page1)
        ..detailsResult = const Right(_details);
      final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

      await cubit.loadRoadmaps();
      final calls = repo.detailsCalls;
      await cubit.retry();

      expect(repo.detailsCalls, calls + 1);
      expect(cubit.state, isA<RoadmapDetailsSuccess>());
      await cubit.close();
    });

    test('TreasureCubit loads and claims treasure milestone', () async {
      treasureCubit.loadCollectedTreasures();
      expect(treasureCubit.state, isA<TreasureLoaded>());

      await treasureCubit.claimTreasureReward(1);
      final state = treasureCubit.state as TreasureLoaded;
      expect(state.collectedTreasures.contains(1), isTrue);
    });

    test('SkillTaskCubit toggles task completion and persists state', () async {
      skillTaskCubit.loadCompletedTasks();
      expect(skillTaskCubit.state, isA<SkillTaskLoaded>());

      await skillTaskCubit.toggleTaskCompletion(taskId: 'task-1');
      final state = skillTaskCubit.state as SkillTaskLoaded;
      expect(state.completedTaskIds.contains('task-1'), isTrue);
    });
    test(
      'RoadmapCubit adds rewarded ad XP (+50 XP) and persists state',
      () async {
        final repo = FakeRoadmapRepository()
          ..listResult = const Right(_page1)
          ..detailsResult = const Right(_details);
        final cubit = buildRoadmapCubit(sharedPreferencesService, repo);

        await cubit.loadRoadmaps();
        expect(cubit.state, isA<RoadmapDetailsSuccess>());

        await cubit.addRewardedAdXp(50);
        final state = cubit.state as RoadmapDetailsSuccess;
        expect(state.rewardedAdXp, equals(50));
        expect(sharedPreferencesService.getRewardedAdXp(), equals(50));
        await cubit.close();
      },
    );
  });
}
