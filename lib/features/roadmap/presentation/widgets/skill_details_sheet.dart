import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_task_card.dart';

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
            // Retrieve latest node state from RoadmapCubit if available
            RoadmapNode currentNode = node;
            if (state is RoadmapSuccess) {
              final found = state.nodes.firstWhere(
                (n) => n.title == node.title,
                orElse: () => node,
              );
              currentNode = found;
            }

            final completedCount = currentNode.completedTasksCount;
            final totalCount = currentNode.totalTasksCount;
            final progressRatio = currentNode.progressRatio;
            final percentageInt = (progressRatio * 100).toInt();

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
                    // Top drag indicator line
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        width: 36.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: colors.onSurface.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),

                    // Header Section
                    Text(
                      currentNode.title,
                      style: textTheme.headlineSmall?.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.secondary,
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

                    // Progress Overview Section
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest.withValues(
                          alpha: 0.7,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: colors.outline, width: 1.w),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                totalCount > 0
                                    ? '$completedCount / $totalCount ${l10n.tasksCompleted}'
                                    : (currentNode.status ==
                                              RoadmapTaskStatus.completed
                                          ? l10n.skillCompleted
                                          : l10n.skillInProgress),
                                style: textTheme.titleSmall?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colors.secondary,
                                ),
                              ),
                              Text(
                                '$percentageInt%',
                                style: textTheme.titleSmall?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colors.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          // Dynamic Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: LinearProgressIndicator(
                              value: progressRatio,
                              minHeight: 10.h,
                              backgroundColor: colors.outline.withValues(
                                alpha: 0.3,
                              ),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Tasks Section Title
                    Row(
                      children: [
                        Icon(
                          Icons.task_alt_rounded,
                          size: 18.r,
                          color: colors.secondary,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          l10n.learningTasks,
                          style: textTheme.labelLarge?.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: colors.secondary,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // Tasks Vertical List
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
                        return SkillTaskCard(
                          key: ValueKey(task.id),
                          task: task,
                          onToggleComplete: () async {
                            final isCompletingTask = !task.isCompleted;
                            final remainingIncompleteCount = currentNode.tasks
                                .where((t) => !t.isCompleted)
                                .length;

                            context.read<RoadmapCubit>().toggleTaskCompletion(
                              nodeTitle: currentNode.title,
                              taskId: task.id,
                            );

                            if (isCompletingTask &&
                                remainingIncompleteCount == 1) {
                              await Future.delayed(
                                const Duration(milliseconds: 300),
                              );
                              if (context.mounted &&
                                  Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                            }
                          },
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
