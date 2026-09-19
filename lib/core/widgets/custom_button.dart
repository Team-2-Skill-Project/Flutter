import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomButtonType { filled, outlined, text }

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final active = isEnabled && !isLoading;

    final effectiveRadius = borderRadius ?? 12.r;
    final effectiveHeight = height ?? 48.h;

    final effectiveBorderColor = borderColor ?? colorScheme.primary;

    final effectiveBorderWidth =
        borderWidth ?? (buttonType == CustomButtonType.outlined ? 1.5 : 0);

    final colors = _resolveColors(colorScheme: colorScheme);

    final content = _buildContent(
      context: context,
      active: active,
      colors: colors,
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: colors.background,
      foregroundColor: colors.foreground,
      disabledBackgroundColor: colors.disabledBackground,
      disabledForegroundColor: colors.disabledForeground,
      elevation: buttonType == CustomButtonType.filled ? elevation : 0,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.25),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
        side: effectiveBorderWidth > 0
            ? BorderSide(
                color: active
                    ? effectiveBorderColor
                    : effectiveBorderColor.withValues(alpha: 0.4),
                width: effectiveBorderWidth,
              )
            : BorderSide.none,
      ),
    );

    Widget button = SizedBox(
      width: width ?? double.infinity,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: active ? onPressed : null,
        style: buttonStyle,
        child: content,
      ),
    );

    if (margin != null) {
      button = Padding(padding: margin!, child: button);
    }

    return button;
  }

  _ButtonColors _resolveColors({required ColorScheme colorScheme}) {
    switch (buttonType) {
      case CustomButtonType.filled:
        return _ButtonColors(
          background: backgroundColor ?? colorScheme.primary,
          foreground: textColor ?? colorScheme.onPrimary,
          disabledBackground:
              disabledBackgroundColor ??
              colorScheme.primary.withValues(alpha: 0.45),
          disabledForeground:
              disabledTextColor ?? colorScheme.onPrimary.withValues(alpha: 0.8),
        );

      case CustomButtonType.outlined:
        return _ButtonColors(
          background: backgroundColor ?? Colors.transparent,
          foreground: textColor ?? colorScheme.primary,
          disabledBackground: disabledBackgroundColor ?? Colors.transparent,
          disabledForeground:
              disabledTextColor ??
              colorScheme.onSurface.withValues(alpha: 0.38),
        );

      case CustomButtonType.text:
        return _ButtonColors(
          background: backgroundColor ?? Colors.transparent,
          foreground: textColor ?? colorScheme.primary,
          disabledBackground: disabledBackgroundColor ?? Colors.transparent,
          disabledForeground:
              disabledTextColor ??
              colorScheme.onSurface.withValues(alpha: 0.38),
        );
    }
  }

  Widget _buildContent({
    required BuildContext context,
    required bool active,
    required _ButtonColors colors,
  }) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 22.r,
          height: 22.r,
          child: CircularProgressIndicator(
            strokeWidth: loadingStrokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              loadingColor ??
                  (buttonType == CustomButtonType.filled
                      ? colors.foreground
                      : Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      );
    }

    if (customChild != null) {
      return customChild!;
    }

    return Row(
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
              style:
                  textStyle ??
                  Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: active
                        ? colors.foreground
                        : colors.disabledForeground,
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
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    required this.disabledBackground,
    required this.disabledForeground,
  });

  final Color background;
  final Color foreground;
  final Color disabledBackground;
  final Color disabledForeground;
}
