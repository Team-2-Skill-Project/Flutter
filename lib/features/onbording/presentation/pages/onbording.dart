import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/career_path_hero_widget.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/job_match_hero_widget.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/onboarding_narrative_section.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/onboarding_top_bar.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/opportunity_hero_widget.dart';
import 'package:MatchIn/features/onbording/presentation/widgets/profile_setup_card.dart';

class Onb1 extends StatefulWidget {
  const Onb1({super.key});

  @override
  State<Onb1> createState() => _Onb1State();
}

class _Onb1State extends State<Onb1> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finishOnboarding() async {
    await getIt<SharedPreferencesService>().onBoardingViewed();
    if (mounted) {
      context.go(AppRoutes.kRegisterView);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            OnboardingTopBar(
              currentPage: _currentPage,
              totalSteps: 3,
              onSkip: () => _goToPage(2),
            ),

            // Main Flow PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  // Step 1: Turn CV into Opportunities
                  _buildStep(
                    centerVisual: const OpportunityHeroWidget(),
                    bottomSection: OnboardingNarrativeSection(
                      title: l10n.turnCvIntoOpportunities,
                      subtitle: l10n.turnCvIntoOpportunitiesDesc,
                      buttonText: l10n.next,
                      onNext: () => _goToPage(1),
                    ),
                  ),

                  // Step 2: Explainable Match
                  _buildStep(
                    centerVisual: const JobMatchHeroWidget(),
                    bottomSection: OnboardingNarrativeSection(
                      title: l10n.getExplainableMatch,
                      subtitle: l10n.getExplainableMatchDesc,
                      titleFontSize: 26.sp,
                      buttonText: l10n.next,
                      onNext: () => _goToPage(2),
                    ),
                  ),

                  // Step 3: Career Profile Setup
                  _buildStep(
                    centerVisual: const CareerPathHeroWidget(),
                    bottomSection: ProfileSetupCard(
                      onStart: _finishOnboarding,
                      onNotNow: _finishOnboarding,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required Widget centerVisual,
    required Widget bottomSection,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Expanded(child: centerVisual),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: bottomSection,
          ),
        ],
      ),
    );
  }
}
