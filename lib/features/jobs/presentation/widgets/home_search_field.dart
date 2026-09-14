import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({
    super.key,
    this.onTap,
    this.onFilterTap,
  });

  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
      ),
      child: TextField(
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: S.of(context).searchJobs,
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: onFilterTap,
            icon: const Icon(
              Icons.tune_rounded,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
