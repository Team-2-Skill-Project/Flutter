import 'package:MatchIn/features/splash/data/data_source/splash_local_data_source.dart';
import 'package:MatchIn/features/splash/domain/repositories/splash_repo.dart';

class SplashRepoImple implements SplashRepo {
  SplashRepoImple({required this.localDataSource});
  final SplashLocalDataSource localDataSource;
  @override
  bool isboardingviewed() {
    // TODO: implement isboardingviewed
    throw UnimplementedError();
  }

  @override
  bool isloggedin() {
    // TODO: implement isloggedin
    throw UnimplementedError();
  }
}
