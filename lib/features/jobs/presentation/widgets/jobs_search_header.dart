import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobsSearchHeader extends StatelessWidget {
  const JobsSearchHeader({super.key, this.onBack, this.onFiltersTap});

  final VoidCallback? onBack;
  final VoidCallback? onFiltersTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8.w, 8.h, 8.w, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),

          Expanded(
            child: Text(
              S.of(context).searchJobsTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          IconButton(
            onPressed: onFiltersTap ?? () {},
            icon: Icon(Icons.tune_rounded, color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
