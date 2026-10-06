import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperienceFormActions extends StatelessWidget {
  const ExperienceFormActions({
    required this.onCancel,
    required this.onSave,
    super.key,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .surface,
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .primary,
                side: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(locale.cancel),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        SizedBox(
          height: 54.h,
          child: FilledButton(
            onPressed: onSave,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .primary,
              foregroundColor: Theme.of(context)
                  .colorScheme
                  .onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(locale.saveExperience),
          ),
        ),
      ],
    );
  }
}
