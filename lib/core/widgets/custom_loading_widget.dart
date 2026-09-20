import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveSize = size ?? 24.r;
    final effectiveColor = color ?? colorScheme.primary;

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
                  theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
