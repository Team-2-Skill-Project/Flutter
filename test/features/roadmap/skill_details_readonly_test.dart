import 'package:MatchIn/core/cache/shared_preferences_helper.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/data/models/skill_task.dart';
import 'package:MatchIn/features/roadmap/domain/repositories/roadmap_repository.dart';
import 'package:MatchIn/features/roadmap/domain/use_cases/get_roadmap_details_use_case.dart';
import 'package:MatchIn/features/roadmap/domain/use_cases/get_roadmaps_use_case.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_details_sheet.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _UnusedRepository extends Fake implements RoadmapRepository {}

const _node = RoadmapNode(
  title: 'Containers',
  status: RoadmapTaskStatus.active,
  tasks: [SkillTask(id: '1', title: 'Docker lab', duration: '6h')],
);

Future<void> _pumpSheet(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final cubit = RoadmapCubit(
    sharedPreferencesService: SharedPreferencesService(
      SharedPreferencesHelper(preferences: prefs),
    ),
    getRoadmapsUseCase: GetRoadmapsUseCase(repository: _UnusedRepository()),
    getRoadmapDetailsUseCase: GetRoadmapDetailsUseCase(
      repository: _UnusedRepository(),
    ),
  );
  addTearDown(cubit.close);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 845),
      builder: (_, _) => MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: const SkillDetailsSheet(node: _node),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('SkillDetailsSheet read-only Phase 1', () {
    testWidgets('task toggle does nothing and keeps design', (tester) async {
      await _pumpSheet(tester);

      expect(find.text('Docker lab'), findsOneWidget);
      expect(find.byIcon(Icons.check_rounded), findsNothing);

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Still incomplete: no toggle, no crash, design intact.
      expect(find.byIcon(Icons.check_rounded), findsNothing);
      expect(find.text('Docker lab'), findsOneWidget);
    });
  });
}
