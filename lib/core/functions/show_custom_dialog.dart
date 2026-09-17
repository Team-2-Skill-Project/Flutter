import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/generated/l10n.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String buttonTitle,
  required IconData icon,
  VoidCallback? onPressed,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,

    // --- animation duration ---
    transitionDuration: const Duration(milliseconds: 300),

    // --- empty page because ui will be built in transitionBuilder ---
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },

    // --- dialog animation ---
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        // --- scale animation ---
        scale: Curves.easeInOutBack.transform(animation.value),

        child: Opacity(
          // --- fade animation ---
          opacity: animation.value,

          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            contentPadding: const EdgeInsets.all(24),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- dialog icon ---
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Theme.of(context).primaryColor,

                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 35.sp,
                  ),
                ),

                SizedBox(height: 20.h),

                // --- dialog title ---
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 12.h),

                // --- dialog message ---
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 24.h),

                // --- dialog button ---
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {
                      // --- close dialog ---
                      Navigator.pop(context);

                      // --- execute custom action ---
                      onPressed?.call();
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.w),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),

                    child: Text(buttonTitle),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showNoInternetConnectionDialog(BuildContext context) {
  showCustomDialog(
    context: context,
    title: S.of(context).noInternetConnection,
    message: S.of(context).pleaseCheckYourInternetConnection,
    buttonTitle: S.of(context).tryAgain,
    icon: Icons.wifi_off_rounded,
  );
}
