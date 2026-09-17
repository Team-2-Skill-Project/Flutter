import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/file_picker_service.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/widgets/cv_file_card.dart';
import 'package:MatchIn/features/applications/presentation/widgets/apply_bottom_button.dart';
import 'package:MatchIn/features/applications/presentation/widgets/apply_header.dart';
import 'package:MatchIn/features/applications/presentation/widgets/cover_note.dart';
import 'package:MatchIn/features/applications/presentation/widgets/job_summary_card.dart';
import 'package:MatchIn/features/applications/presentation/widgets/user_info.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ApplyForRoleViewBody extends StatelessWidget {
  const ApplyForRoleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        ApplyHeader(
          title: s.applyForRole,
          currentStep: 1,
          totalSteps: 3,
        ),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Column(
              children: [
                const JobSummaryCard(),
                SizedBox(height: 24.h),
                const UserInfo(),
                SizedBox(height: 24.h),
                CvFileCard(
                  onUpload: () async {
                    final file =
                        await getIt<FilePickerService>()
                            .pickCv();

                    if (file == null) {
                      return;
                    }

                    debugPrint('Selected CV: ${file.name}');
                  },
                ),
                SizedBox(height: 24.h),
                const CoverNote(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
        ApplyBottomButton(
          label: s.continueText,
          helperText: s.nextApplicationQuestions,
          onPressed: () {
            context.push(AppRoutes.applicationQuestions);
          },
        ),
      ],
    );
  }
}
