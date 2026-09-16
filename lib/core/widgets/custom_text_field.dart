import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.isPassword = false,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.fillColor,
    this.filled = true,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.cursorColor,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;

  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;

  final bool isPassword;
  final bool? obscureText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  final List<TextInputFormatter>? inputFormatters;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final VoidCallback? onTap;

  final bool readOnly;
  final bool enabled;
  final bool autofocus;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final Color? fillColor;
  final bool filled;

  final double? borderRadius;

  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;

  final EdgeInsetsGeometry? contentPadding;

  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final Color? cursorColor;

  @override
  State<CustomTextField> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.obscureText ?? widget.isPassword;
  }

  @override
  void didUpdateWidget(
    covariant CustomTextField oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.obscureText != widget.obscureText &&
        widget.obscureText != null) {
      _obscureText = widget.obscureText!;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveRadius = widget.borderRadius ?? 8.r;

    final effectiveBorderColor =
        widget.borderColor ?? theme.dividerColor;

    final effectiveFocusedColor =
        widget.focusedBorderColor ?? colorScheme.primary;

    final effectiveErrorColor =
        widget.errorBorderColor ?? colorScheme.error;

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: effectiveBorderColor,
        width: 1,
      ),
    );

    Widget? effectiveSuffixIcon = widget.suffixIcon;

    if (widget.isPassword) {
      effectiveSuffixIcon = IconButton(
        onPressed: _togglePasswordVisibility,
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20.sp,
          color: colorScheme.onSurface.withValues(
            alpha: 0.6,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style:
                widget.labelStyle ??
                theme.textTheme.labelLarge,
          ),

          SizedBox(height: 6.h),
        ],

        TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          focusNode: widget.focusNode,

          obscureText: _obscureText,

          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,

          inputFormatters: widget.inputFormatters,

          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onSaved: widget.onSaved,
          onTap: widget.onTap,

          readOnly: widget.readOnly,
          enabled: widget.enabled,
          autofocus: widget.autofocus,

          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,

          cursorColor:
              widget.cursorColor ?? colorScheme.primary,

          style:
              widget.textStyle ??
              theme.textTheme.bodyMedium,

          decoration: InputDecoration(
            hintText: widget.hintText,

            hintStyle:
                widget.hintStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
                ),

            helperText: widget.helperText,
            errorText: widget.errorText,

            filled: widget.filled,
            fillColor:
                widget.fillColor ?? colorScheme.surface,

            prefixIcon: widget.prefixIcon,
            suffixIcon: effectiveSuffixIcon,

            prefix: widget.prefix,
            suffix: widget.suffix,

            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 14.h,
                ),

            border: outlineBorder,
            enabledBorder: outlineBorder,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                effectiveRadius,
              ),
              borderSide: BorderSide(
                color: effectiveFocusedColor,
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                effectiveRadius,
              ),
              borderSide: BorderSide(
                color: effectiveErrorColor,
                width: 1,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                effectiveRadius,
              ),
              borderSide: BorderSide(
                color: effectiveErrorColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
