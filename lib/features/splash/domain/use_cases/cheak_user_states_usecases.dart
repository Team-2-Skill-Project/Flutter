// اعملي امبورت لـ SplashRepo باللمبة الصفرا
// import '.../splash_repo.dart';

import 'package:MatchIn/features/splash/domain/repositories/splash_repo.dart';

class CheckUserStatusUseCase {
  final SplashRepo repository;

  CheckUserStatusUseCase({required this.repository});

  bool checkOnboarding() {
    return repository.isboardingviewed();
  }

  bool checkLogin() {
    return repository.isloggedin();
  }
}