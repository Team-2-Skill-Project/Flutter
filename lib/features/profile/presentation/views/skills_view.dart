import 'package:MatchIn/features/profile/presentation/widgets/skills_widgets/skills_view_body.dart';
import 'package:flutter/material.dart';

class SkillsView extends StatelessWidget {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: SkillsViewBody()),
    );
  }
}
