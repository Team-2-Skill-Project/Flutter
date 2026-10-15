import 'package:MatchIn/core/widgets/error/app_error.dart';
import 'package:MatchIn/core/widgets/loading/app_loading.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/domain/entities/roadmap_entity.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/treasure_cubit/treasure_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/utils/roadmap_node_mapper.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_content_widget.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_selector_sheet.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapViewBody extends StatelessWidget {
  const RoadmapViewBody({super.key, this.nodes});

  final List<RoadmapNode>? nodes;

  @override
  Widget build(BuildContext context) {
    if (nodes != null && nodes!.isNotEmpty) {
      return RoadmapContentWidget(nodes: nodes!);
    }

    return BlocBuilder<RoadmapCubit, RoadmapState>(
      builder: (context, state) {
        switch (state) {
          case RoadmapsLoading():
          case RoadmapLoading():
            return const AppLoadingWidget();
          case RoadmapsSuccess():
            // Non-empty lists chain into details loading inside the
            // cubit, so this frame is transient by design.
            if (state.roadmaps.isEmpty) return _emptyView(context);
            return const AppLoadingWidget();
          case RoadmapDetailsSuccess():
            final locale = S.of(context);
            final mapped = RoadmapNodeMapper.mapMilestones(
              state.details.milestones,
              durationLabel: (hours) => locale.estimatedHours(hours),
            );
            return Column(
              children: [
                _selectorBar(context, state.details),
                Expanded(
                  child: BlocBuilder<TreasureCubit, TreasureState>(
                    builder: (context, treasureState) {
                      final collectedTreasures = treasureState is TreasureLoaded
                          ? treasureState.collectedTreasures
                          : <int>{};

                      return RoadmapContentWidget(
                        nodes: mapped,
                        collectedTreasures: collectedTreasures,
                        rewardedAdXp: state.rewardedAdXp,
                      );
                    },
                  ),
                ),
              ],
            );
          case RoadmapFailure():
            return AppErrorWidget(
              message: state.errorMessage,
              onRetry: () => context.read<RoadmapCubit>().retry(),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _emptyView(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.map_outlined,
              size: 48.r,
              color: colors.onSurfaceVariant,
            ),
            SizedBox(height: 16.h),
            Text(
              S.of(context).noRoadmaps,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectorBar(BuildContext context, RoadmapEntity details) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return InkWell(
      onTap: () => _openSelector(context),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (details.targetRole != null &&
                      details.targetRole!.trim().isNotEmpty)
                    Text(
                      details.targetRole!.trim(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openSelector(BuildContext context) async {
    final cubit = context.read<RoadmapCubit>();
    final selected = await RoadmapSelectorSheet.show(
      context,
      cubit: cubit,
    );
    if (selected == null || !context.mounted) return;
    await context.read<RoadmapCubit>().selectRoadmap(selected);
  }
}
