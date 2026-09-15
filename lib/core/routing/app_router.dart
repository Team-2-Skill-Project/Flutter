import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/features/jobs/presentation/views/home_view.dart';
import 'package:MatchIn/features/jobs/presentation/views/jobs_search_view.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          return const HomeView();
        },
      ),

      GoRoute(
        path: AppRoutes.jobsSearch,
        builder: (context, state) {
          return const JobsSearchView();
        },
      ),

      // TODO: Add Job Details route.

      // TODO: Add application routes.
    ],
  );
}
