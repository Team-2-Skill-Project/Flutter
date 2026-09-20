import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectTextField extends StatelessWidget {
  const ProjectTextField({
    required this.label,
    this.hint,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixIcon,
    this.trailingLabel,
    this.onChanged,
    super.key,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final String? trailingLabel;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailingLabel != null)
              Text(
                trailingLabel!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, size: 20.r),
            filled: true,
            fillColor: colors.surface,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: maxLines > 1 ? 14.h : 12.h,
            ),
            border: _border(colors),
            enabledBorder: _border(colors),
            focusedBorder: _border(
              colors,
              color: colors.primary,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(
    ColorScheme colors, {
    Color? color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: color ?? colors.outlineVariant,
        width: 1,
      ),
    );
  }
}
