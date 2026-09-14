import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomButtonType {
  filled,
  outlined,
  text,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonType = CustomButtonType.filled,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation = 0,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing,
    this.padding,
    this.margin,
    this.textStyle,
    this.loadingColor,
    this.loadingStrokeWidth = 2.5,
    this.customChild,
  });

  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final CustomButtonType buttonType;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double elevation;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? iconSpacing;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final Color? loadingColor;
  final double loadingStrokeWidth;
  final Widget? customChild;

  @override
  Widget build(BuildContext context) {
    final bool active = isEnabled && !isLoading;
    final effectiveRadius = borderRadius ?? 12.r;
    final effectiveHeight = height ?? 48.h;
    final effectiveBorderColor = borderColor ?? (buttonType == CustomButtonType.outlined ? AppColors.primary : Colors.transparent);
    final effectiveBorderWidth = borderWidth ?? (buttonType == CustomButtonType.outlined ? 1.5 : 0.0);

    Color defaultBg;
    Color defaultFg;
    Color defaultDisabledBg;
    Color defaultDisabledFg;

    switch (buttonType) {
      case CustomButtonType.filled:
        defaultBg = backgroundColor ?? AppColors.primary;
        defaultFg = textColor ?? Colors.white;
        defaultDisabledBg = disabledBackgroundColor ?? AppColors.primary.withValues(alpha: 0.45);
        defaultDisabledFg = disabledTextColor ?? Colors.white.withValues(alpha: 0.8);
        break;
      case CustomButtonType.outlined:
        defaultBg = backgroundColor ?? Colors.transparent;
        defaultFg = textColor ?? AppColors.primary;
        defaultDisabledBg = disabledBackgroundColor ?? Colors.transparent;
        defaultDisabledFg = disabledTextColor ?? Colors.grey;
        break;
      case CustomButtonType.text:
        defaultBg = backgroundColor ?? Colors.transparent;
        defaultFg = textColor ?? AppColors.primary;
        defaultDisabledBg = disabledBackgroundColor ?? Colors.transparent;
        defaultDisabledFg = disabledTextColor ?? Colors.grey;
        break;
    }

    Widget content;
    if (isLoading) {
      content = Center(
        child: SizedBox(
          width: 22.w,
          height: 22.w,
          child: CircularProgressIndicator(
            strokeWidth: loadingStrokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              loadingColor ?? (buttonType == CustomButtonType.filled ? Colors.white : AppColors.primary),
            ),
          ),
        ),
      );
    } else if (customChild != null) {
      content = customChild!;
    } else {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            prefixIcon!,
            SizedBox(width: iconSpacing ?? 8.w),
          ],
          if (text != null)
            Flexible(
              child: Text(
                text!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: active ? defaultFg : defaultDisabledFg,
                      letterSpacing: 0.15,
                    ),
              ),
            ),
          if (suffixIcon != null) ...[
            SizedBox(width: iconSpacing ?? 8.w),
            suffixIcon!,
          ],
        ],
      );
    }

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: defaultBg,
      foregroundColor: defaultFg,
      disabledBackgroundColor: defaultDisabledBg,
      disabledForegroundColor: defaultDisabledFg,
      elevation: buttonType == CustomButtonType.filled ? elevation : 0,
      shadowColor: Colors.black26,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
        side: effectiveBorderWidth > 0
            ? BorderSide(
                color: active ? effectiveBorderColor : effectiveBorderColor.withValues(alpha: 0.4),
                width: effectiveBorderWidth,
              )
            : BorderSide.none,
      ),
    );

    Widget buttonWidget = SizedBox(
      width: width ?? double.infinity,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: active ? onPressed : null,
        style: buttonStyle,
        child: content,
      ),
    );

    if (margin != null) {
      buttonWidget = Padding(padding: margin!, child: buttonWidget);
    }

    return buttonWidget;
  }
}
