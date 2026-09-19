import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';

/// Standardized loading indicator widget across the application.
class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 2.5,
    this.message,
    this.messageStyle,
  });

  final double? size;
  final Color? color;
  final double strokeWidth;
  final String? message;
  final TextStyle? messageStyle;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? 24.r;
    final effectiveColor = color ?? context.colors.primary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: effectiveSize,
            height: effectiveSize,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 12.h),
            Text(
              message!,
              textAlign: TextAlign.center,
              style:
                  messageStyle ??
                  context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurface.withValues(alpha: 0.6),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
