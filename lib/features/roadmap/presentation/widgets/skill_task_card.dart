import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/roadmap/data/models/skill_task.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/resource_button.dart';

class SkillTaskCard extends StatefulWidget {
  const SkillTaskCard({
    super.key,
    required this.task,
    required this.onToggleComplete,
  });

  final SkillTask task;
  final VoidCallback onToggleComplete;

  @override
  State<SkillTaskCard> createState() => _SkillTaskCardState();
}

class _SkillTaskCardState extends State<SkillTaskCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.task.isCompleted;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.surfaceVariant.withValues(alpha: 0.6)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isCompleted
              ? AppColors.success.withValues(alpha: 0.4)
              : AppColors.darkDivider,
          width: 1.w,
        ),
        boxShadow: [
          if (!_isExpanded)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6.r,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleExpanded,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Collapsed Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Completion Checkbox Indicator
                    GestureDetector(
                      onTap: widget.onToggleComplete,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 26.r,
                        height: 26.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? AppColors.success
                              : Colors.transparent,
                          border: Border.all(
                            color: isCompleted
                                ? AppColors.success
                                : AppColors.border,
                            width: 2.w,
                          ),
                        ),
                        child: isCompleted
                            ? Icon(
                                Icons.check_rounded,
                                size: 16.r,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Task Title & Duration
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: isCompleted
                                  ? AppColors.textSecondary
                                  : AppColors.secondary,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14.r,
                                color: AppColors.textHint,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.task.duration,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textHint,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Expand / Collapse Chevron
                    AnimatedRotation(
                      turns: _isExpanded ? 0.25 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 24.r,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                // Expanded Section with AnimatedSize
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: _isExpanded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12.h),
                            Divider(color: AppColors.darkDivider, height: 1.h),
                            SizedBox(height: 12.h),

                            // Description
                            if (widget.task.description != null &&
                                widget.task.description!.isNotEmpty) ...[
                              Text(
                                widget.task.description!,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(height: 14.h),
                            ],

                            // Resources Section
                            if (widget.task.resources.isNotEmpty) ...[
                              Text(
                                'Resources',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: widget.task.resources.map((res) {
                                  return ResourceButton(resource: res);
                                }).toList(),
                              ),
                            ],
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
