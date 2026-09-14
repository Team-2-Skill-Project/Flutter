import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.showBackButton = true,
    this.onBack,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation = 0,
    this.height,
    this.titleStyle,
    this.systemOverlayStyle,
  });

  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double elevation;
  final double? height;
  final TextStyle? titleStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 56.h);

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && showBackButton) {
      effectiveLeading = SizedBox(
        width: 40.w,
        height: 40.h,
        child: IconButton(
          onPressed: onBack ??
              () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  Navigator.maybePop(context);
                }
              },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: AppColors.textPrimary,
          ),
          splashRadius: 20.r,
          padding: EdgeInsets.zero,
        ),
      );
    }

    Widget? effectiveTitle = titleWidget;
    if (effectiveTitle == null && title != null) {
      effectiveTitle = Text(
        title!,
        style: titleStyle ??
            TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.45,
            ),
      );
    }

    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.background,
      elevation: elevation,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      leading: effectiveLeading,
      automaticallyImplyLeading: false,
      title: effectiveTitle,
      actions: actions,
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
      toolbarHeight: height ?? 56.h,
    );
  }
}
