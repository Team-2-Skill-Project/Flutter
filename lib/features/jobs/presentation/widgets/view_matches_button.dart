import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewMatchesButton extends StatelessWidget {
  const ViewMatchesButton({super.key, this.onViewMatches});

  final VoidCallback? onViewMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38.h,
      child: ElevatedButton(
        onPressed: onViewMatches ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).viewMatches),
            SizedBox(width: 6.w),
            Icon(Icons.arrow_forward_rounded, size: 17.sp),
          ],
        ),
      ),
    );
  }
}
