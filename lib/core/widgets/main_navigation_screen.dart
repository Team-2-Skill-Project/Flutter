import 'package:MatchIn/core/widgets/remove_me.dart';
import 'package:MatchIn/features/jobs/presentation/views/home_view.dart';
import 'package:MatchIn/features/roadmap/presentation/views/roadmap_view.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeView(),
    const AiChatView(),
    const SavedJobsView(),
    const RoadmapView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.grey.shade200,
            tabs: [
              GButton(icon: Icons.home_outlined, text: S.of(context).home),
              GButton(
                icon: Icons.smart_toy_outlined,
                text: S.of(context).roadMap,
              ),
              GButton(
                icon: Icons.bookmark_outline,
                text: S.of(context).savedJobs,
              ),
              GButton(icon: Icons.route_outlined, text: S.of(context).roadMap),
              GButton(icon: Icons.person_outline, text: S.of(context).profile),
            ],
          ),
        ),
      ),
    );
  }
}
