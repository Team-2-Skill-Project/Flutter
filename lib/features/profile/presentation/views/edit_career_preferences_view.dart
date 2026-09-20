import 'package:MatchIn/features/profile/presentation/widgets/career_preferences_widgets/career_preferences_view_body.dart';
import 'package:flutter/material.dart';

class CareerPreferencesView extends StatelessWidget {
  const CareerPreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: CareerPreferencesViewBody()),
    );
  }
}
