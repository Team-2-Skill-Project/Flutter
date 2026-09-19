import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/saved/presentation/models/applied_job_ui_model.dart';
import 'package:MatchIn/features/saved/presentation/widgets/match_badge.dart';

class AppliedJobCard extends StatelessWidget {
  const AppliedJobCard({
    super.key,
    required this.application,
    this.onViewApplicationTap,
    this.onCardTap,
  });

  final AppliedJobUiModel application;
  final VoidCallback? onViewApplicationTap;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) {
    final isInterview = application.status == ApplicationStatus.interview;

    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isInterview ? null : Colors.white,
          gradient: isInterview
              ? const LinearGradient(
                  colors: [Colors.white, Color(0xFFFAF8F4)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          border: Border.all(
            color: isInterview
                ? const Color(0x4DC88A26) // rgba(200, 138, 38, 0.3)
                : AppColors.border,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Logo + Title/Company + Status Chip
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Avatar
                Container(
                  width: 40.w,
                  height: 40.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: application.logoBgColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: application.logoTextColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    application.companyInitials,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: application.logoTextColor,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Title and Company
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.title,
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 19 / 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        application.company,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          height: 16 / 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Chip
                _buildStatusChip(application.status),
              ],
            ),
            SizedBox(height: 12.h),

            // Metadata Tags + Applied Time
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...application.tags.map((tag) => _buildTag(tag)),
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    application.appliedTime,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 16 / 11,
                    ),
                  ),
                ),
              ],
            ),

            // Match Badge if available
            if (application.matchLevel != null) ...[
              SizedBox(height: 10.h),
              MatchBadge(matchLevel: application.matchLevel!),
            ],

            // Highlight Note (e.g. Interview scheduled)
            if (application.highlightNote != null) ...[
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0x1AC88A26), // rgba(200, 138, 38, 0.1)
                  border: Border.all(
                    color: const Color(0x33C88A26), // rgba(200, 138, 38, 0.2)
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16.sp,
                      color: const Color(0xFFC88A26),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        application.highlightNote!,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8F610E),
                          height: 16 / 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 12.h),

            // Bottom Action Row
            Container(
              padding: EdgeInsets.only(top: 8.h),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFFAF8F4),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    application.footerStatus,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 16 / 11,
                    ),
                  ),
                  InkWell(
                    onTap: onViewApplicationTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View application',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            height: 16 / 12,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.chevron_right,
                          size: 16.sp,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ApplicationStatus status) {
    Color textColor;
    Color bgColor;
    Color borderColor;
    String label;

    switch (status) {
      case ApplicationStatus.applied:
        textColor = AppColors.primary;
        bgColor = const Color(0x1A1F365C); // rgba(31, 54, 92, 0.1)
        borderColor = const Color(0x261F365C); // rgba(31, 54, 92, 0.15)
        label = 'Applied';
        break;
      case ApplicationStatus.inReview:
        textColor = AppColors.secondary;
        bgColor = const Color(0x1AD06B4F); // rgba(208, 107, 79, 0.1)
        borderColor = const Color(0x33D06B4F); // rgba(208, 107, 79, 0.2)
        label = 'In Review';
        break;
      case ApplicationStatus.interview:
        textColor = const Color(0xFF9E6E18);
        bgColor = const Color(0x26C88A26); // rgba(200, 138, 38, 0.15)
        borderColor = const Color(0x4DC88A26); // rgba(200, 138, 38, 0.3)
        label = 'Interview';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
              height: 16 / 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 16 / 11,
        ),
      ),
    );
  }
}
