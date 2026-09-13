import 'package:MatchIn/features/jobs/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: HomeHeader()),
      ),
    );
  }
}
