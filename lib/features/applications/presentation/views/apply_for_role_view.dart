import 'package:MatchIn/features/applications/presentation/widgets/apply_for_role_view_body.dart';
import 'package:flutter/material.dart';

class ApplyForRoleView extends StatelessWidget {
  const ApplyForRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: ApplyForRoleViewBody()),
    );
  }
}
