import 'package:MatchIn/core/cache/shared_preferences_helper.dart';
import 'package:MatchIn/core/networking/api_end_points.dart';
import 'package:MatchIn/core/services/app_config_service.dart';
import 'package:MatchIn/core/services/app_initializer.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeBaseUrlProvider implements BaseUrlProvider {
  FakeBaseUrlProvider({this.url, this.error});

  String? url;
  Object? error;

  @override
  Future<String?> fetchBaseUrl() async {
    if (error != null) {
      throw error!;
    }
    return url;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesService preferencesService;
  late FakeBaseUrlProvider provider;
  late AppConfigService configService;
  late Dio dio;
  late AppInitializer initializer;
  late String savedBaseUrl;
  late int pushCalls;
  late int adsCalls;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    preferencesService = SharedPreferencesService(
      SharedPreferencesHelper(preferences: prefs),
    );
    provider = FakeBaseUrlProvider();
    configService = AppConfigService(
      sharedPreferencesService: preferencesService,
      baseUrlProvider: provider,
    );
    dio = Dio()..options.baseUrl = EndPoint.defaultBaseUrl;
    pushCalls = 0;
    adsCalls = 0;
    initializer = AppInitializer(
      appConfigService: configService,
      sharedPreferencesService: preferencesService,
      dio: dio,
      // --- Static SDK singletons cannot run in unit tests ---
      pushInitializer: (_) async => pushCalls++,
      adsInitializer: () async => adsCalls++,
    );
    savedBaseUrl = EndPoint.baseUrl;
    EndPoint.baseUrl = EndPoint.defaultBaseUrl;
  });

  tearDown(() {
    EndPoint.baseUrl = savedBaseUrl;
  });

  group('AppInitializer.refreshBaseUrl', () {
    test('applies a valid Firebase url centrally and to Dio', () async {
      provider.url = 'https://firebase.example/api';

      await initializer.refreshBaseUrl();

      expect(EndPoint.baseUrl, 'https://firebase.example/api/');
      expect(dio.options.baseUrl, 'https://firebase.example/api/');
      expect(
        preferencesService.getApiBaseUrl(),
        'https://firebase.example/api/',
      );
    });

    test('keeps the centralized config when Firebase fails', () async {
      provider.error = FirebaseException(
        plugin: 'cloud_firestore',
        code: 'unavailable',
      );

      await initializer.refreshBaseUrl();

      expect(EndPoint.baseUrl, EndPoint.defaultBaseUrl);
      expect(dio.options.baseUrl, EndPoint.defaultBaseUrl);
    });
  });

  group('AppInitializer.init without Firebase', () {
    test('startup still works and keeps the locator-resolved url', () async {
      // --- The service locator resolves this before init() runs ---
      EndPoint.baseUrl = EndPoint.defaultBaseUrl;
      provider.error = FirebaseException(
        plugin: 'cloud_firestore',
        code: 'app-not-initialized',
        message: 'Firebase is not initialized',
      );

      await initializer.init();

      expect(EndPoint.baseUrl, EndPoint.defaultBaseUrl);
      // --- Background hooks settle after init returns ---
      await Future<void>.delayed(const Duration(milliseconds: 50));
      // --- Startup sequence is preserved even when Firebase fails ---
      expect(pushCalls, 1);
      expect(adsCalls, 1);
    });

    test('init never disturbs the centralized url on failure', () async {
      EndPoint.baseUrl = 'https://resolved.example/api/';
      provider.error = FirebaseException(
        plugin: 'cloud_firestore',
        code: 'unavailable',
      );

      await initializer.init();

      expect(EndPoint.baseUrl, 'https://resolved.example/api/');
    });
  });
}
