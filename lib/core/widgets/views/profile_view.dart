import 'package:flutter/material.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/widgets/empty/app_empty.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile)),
      body: AppEmptyWidget(
        icon: Icons.person_outline_rounded,
        title: context.l10n.profile,
        message: 'Your career profile overview and preferences.',
      ),
    );
  }
}
