import 'package:MatchIn/features/profile/presentation/widgets/projects_widgets/projects_view_body.dart';
import 'package:flutter/material.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: ProjectsViewBody()),
    );
  }
}
