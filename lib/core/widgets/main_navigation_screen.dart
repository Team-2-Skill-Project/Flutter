import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/widgets/views/ai_chat_view.dart';
import 'package:MatchIn/core/widgets/views/profile_view.dart';
import 'package:MatchIn/core/widgets/views/saved_jobs_view.dart';
import 'package:MatchIn/features/jobs/presentation/views/home_view.dart';
import 'package:MatchIn/features/roadmap/presentation/views/roadmap_view.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeView(),
    AiChatView(),
    SavedJobsView(),
    RoadmapView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

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
            color: colors.onSurface.withValues(alpha: 0.6),
            activeColor: colors.primary,
            tabBackgroundColor: colors.primary.withValues(alpha: 0.12),
            tabs: [
              GButton(icon: Icons.home_outlined, text: l10n.home),
              GButton(icon: Icons.smart_toy_outlined, text: l10n.chatBot),
              GButton(icon: Icons.bookmark_outline, text: l10n.savedJobs),
              GButton(icon: Icons.route_outlined, text: l10n.roadMap),
              GButton(icon: Icons.person_outline, text: l10n.profile),
            ],
          ),
        ),
      ),
    );
  }
}
