import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/utils/roadmap_node_mapper.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_details_progress_overview.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_details_section_title.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillDetailsSheet extends StatelessWidget {
  const SkillDetailsSheet({super.key, required this.node});

  final RoadmapNode node;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final l10n = context.l10n;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return BlocBuilder<RoadmapCubit, RoadmapState>(
          builder: (context, state) {
            RoadmapNode currentNode = node;
            if (state is RoadmapDetailsSuccess) {
              final nodes = RoadmapNodeMapper.mapMilestones(
                state.details.milestones,
                durationLabel: (hours) => l10n.estimatedHours(hours),
              );
              currentNode = nodes.firstWhere(
                (candidate) =>
                    candidate.id != null &&
                    node.id != null &&
                    candidate.id == node.id,
                orElse: () => nodes.firstWhere(
                  (candidate) => candidate.title == node.title,
                  orElse: () => node,
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: SafeArea(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  children: [
                    Text(
                      currentNode.title,
                      style: textTheme.headlineSmall?.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                      ),
                    ),
                    if (currentNode.subtitle != null &&
                        currentNode.subtitle!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        currentNode.subtitle!,
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                    SizedBox(height: 20.h),
                    SkillDetailsProgressOverview(node: currentNode),
                    SizedBox(height: 24.h),
                    const SkillDetailsSectionTitle(),
                    SizedBox(height: 12.h),
                    if (currentNode.tasks.isEmpty) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                          child: Text(
                            l10n.noLearningTasks,
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      ...currentNode.tasks.map((task) {
                        // TODO(roadmap-phase-3): connect backend task
                        // completion. Until then the sheet is read-only:
                        // null keeps the design while disabling toggles,
                        // so nothing is written to SharedPreferences.
                        return SkillTaskCard(
                          key: ValueKey(task.id),
                          task: task,
                          onToggleComplete: null,
                        );
                      }),
                    ],
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
