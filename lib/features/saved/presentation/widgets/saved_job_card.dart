import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/saved/presentation/models/saved_job_ui_model.dart';
import 'package:MatchIn/features/saved/presentation/widgets/match_badge.dart';

class SavedJobCard extends StatelessWidget {
  const SavedJobCard({
    super.key,
    required this.job,
    this.onApplyTap,
    this.onBookmarkTap,
    this.onCardTap,
  });

  final SavedJobUiModel job;
  final VoidCallback? onApplyTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Logo/Avatar + Title/Company + Bookmark
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Avatar
                Container(
                  width: 40.w,
                  height: 40.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: job.logoBgColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: job.logoTextColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    job.companyInitials,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: job.logoTextColor,
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
                        job.title,
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
                        job.company,
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

                // Bookmark Icon Button
                InkWell(
                  onTap: onBookmarkTap,
                  borderRadius: BorderRadius.circular(4.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Icon(
                      job.isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 20.sp,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Metadata Tags + Posted Time
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...job.tags.map((tag) => _buildTag(tag)),
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    job.postedTime,
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
            SizedBox(height: 12.h),

            // Match Badge & Reason
            MatchBadge(matchLevel: job.matchLevel),
            SizedBox(height: 4.h),
            Text(
              job.matchReason,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 14 / 11,
              ),
            ),
            SizedBox(height: 14.h),

            // Card Action: Footer note & Apply Now
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
                    job.footerNote,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 16 / 11,
                    ),
                  ),
                  InkWell(
                    onTap: onApplyTap,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 32.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Apply Now',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 16 / 12,
                        ),
                      ),
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
