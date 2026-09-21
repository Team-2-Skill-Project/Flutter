import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MatchIn/features/saved/domain/entities/saved_job_entity.dart';
import 'package:MatchIn/features/saved/domain/use_cases/get_saved_jobs_use_case.dart';
import 'package:MatchIn/features/saved/domain/use_cases/save_job_use_case.dart';
import 'package:MatchIn/features/saved/domain/use_cases/unsave_job_use_case.dart';
import 'package:MatchIn/features/saved/presentation/cubit/saved_jobs_state.dart';

class SavedJobsCubit extends Cubit<SavedJobsState> {
  SavedJobsCubit({
    required this.getSavedJobsUseCase,
    required this.saveJobUseCase,
    required this.unsaveJobUseCase,
  }) : super(const SavedJobsInitial());

  final GetSavedJobsUseCase getSavedJobsUseCase;
  final SaveJobUseCase saveJobUseCase;
  final UnsaveJobUseCase unsaveJobUseCase;

  Future<void> fetchSavedJobs({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(const SavedJobsLoading());
    }

    final result = await getSavedJobsUseCase(page: 1, perPage: 15);

    result.fold(
      (failure) => emit(SavedJobsError(message: failure.message)),
      (paginatedData) {
        emit(
          SavedJobsLoaded(
            jobs: paginatedData.jobs,
            currentPage: paginatedData.currentPage,
            hasMore: paginatedData.hasMorePages,
          ),
        );
      },
    );
  }

  Future<void> loadMoreSavedJobs() async {
    final currentState = state;
    if (currentState is! SavedJobsLoaded ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await getSavedJobsUseCase(page: nextPage, perPage: 15);

    result.fold(
      (failure) {
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (paginatedData) {
        // Deduplicate jobs by id
        final existingIds = currentState.jobs.map((j) => j.id).toSet();
        final newJobs = paginatedData.jobs
            .where((j) => !existingIds.contains(j.id))
            .toList();

        emit(
          SavedJobsLoaded(
            jobs: [...currentState.jobs, ...newJobs],
            currentPage: paginatedData.currentPage,
            hasMore: paginatedData.hasMorePages,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> toggleBookmark(SavedJobEntity job) async {
    final currentState = state;
    if (currentState is! SavedJobsLoaded) return;

    final wasSaved = job.isSaved;
    final targetSaved = !wasSaved;

    // Optimistic UI update
    final updatedJobs = currentState.jobs
        .map((j) => j.id == job.id ? j.copyWith(isSaved: targetSaved) : j)
        .toList();

    emit(currentState.copyWith(jobs: updatedJobs));

    // Call API
    final result = targetSaved
        ? await saveJobUseCase(jobPostId: job.id)
        : await unsaveJobUseCase(jobPostId: job.id);

    result.fold(
      (failure) {
        // Revert on failure
        final revertedJobs = currentState.jobs
            .map((j) => j.id == job.id ? j.copyWith(isSaved: wasSaved) : j)
            .toList();
        emit(currentState.copyWith(jobs: revertedJobs));
      },
      (isSaved) {
        // Update with server confirmation
        final confirmedJobs = currentState.jobs
            .map((j) => j.id == job.id ? j.copyWith(isSaved: isSaved) : j)
            .toList();
        emit(currentState.copyWith(jobs: confirmedJobs));
      },
    );
  }
}
