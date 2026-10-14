import 'dart:typed_data';

import 'package:MatchIn/core/cache/secure_storage_helper.dart';
import 'package:MatchIn/core/cache/shared_preferences_helper.dart';
import 'package:MatchIn/core/errors/exceptions.dart';
import 'package:MatchIn/core/networking/api_end_points.dart';
import 'package:MatchIn/core/networking/dio_consumer.dart';
import 'package:MatchIn/core/services/secure_storage_service.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _CaptureAdapter implements HttpClientAdapter {
  _CaptureAdapter({this.statusCode = 200});

  final int statusCode;
  Uri? capturedUri;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    capturedUri = options.uri;
    if (statusCode == 200) {
      return ResponseBody.fromString('{}', 200);
    }
    return ResponseBody.fromString(
      '{"message":"Unauthenticated."}',
      statusCode,
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeSecureStorageService extends SecureStorageService {
  _FakeSecureStorageService() : super(SecureStorageHelper());

  @override
  Future<String?> getAccessToken() async => null;

  @override
  Future<String?> getRefreshToken() async => null;

  @override
  Future<void> deleteTokens() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesService preferencesService;
  late _CaptureAdapter adapter;
  late String savedBaseUrl;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    preferencesService = SharedPreferencesService(
      SharedPreferencesHelper(preferences: prefs),
    );
    adapter = _CaptureAdapter();
    savedBaseUrl = EndPoint.baseUrl;
    EndPoint.baseUrl = '';
  });

  tearDown(() {
    EndPoint.baseUrl = savedBaseUrl;
  });

  DioConsumer buildConsumer() {
    final dio = Dio()..httpClientAdapter = adapter;
    return DioConsumer(
      dio: dio,
      secureStorageService: _FakeSecureStorageService(),
      sharedPreferencesService: preferencesService,
    );
  }

  group('DioConsumer centralized base URL', () {
    test('sends no request without a resolved base URL', () async {
      // --- Neither Firestore nor cache provided a URL: every verb
      // --- fails fast instead of hitting an obsolete backend. ---
      final consumer = buildConsumer();

      await expectLater(
        consumer.get('jobs'),
        throwsA(
          isA<ServerException>().having(
            (e) => e.errorModel.errorMessage,
            'errorMessage',
            contains('unavailable'),
          ),
        ),
      );
      await expectLater(consumer.post('jobs'), throwsA(isA<ServerException>()));
      await expectLater(
        consumer.put('jobs/1'),
        throwsA(isA<ServerException>()),
      );
      await expectLater(
        consumer.patch('jobs/1'),
        throwsA(isA<ServerException>()),
      );
      await expectLater(
        consumer.delete('jobs/1'),
        throwsA(isA<ServerException>()),
      );

      // --- The adapter was never reached: zero requests sent ---
      expect(adapter.capturedUri, isNull);
    });

    test('uses the resolved EndPoint base URL', () async {
      EndPoint.baseUrl = 'https://resolved.example/api/';

      await buildConsumer().get('jobs');

      expect(
        adapter.capturedUri.toString(),
        'https://resolved.example/api/jobs',
      );
    });

    test('a centralized URL update affects subsequent requests', () async {
      EndPoint.baseUrl = 'https://first.example/api/';
      final consumer = buildConsumer();

      await consumer.get('jobs');
      expect(adapter.capturedUri.toString(), 'https://first.example/api/jobs');

      // --- Same Dio instance, new centralized configuration ---
      EndPoint.baseUrl = 'https://second.example/api/';
      consumer.dio.options.baseUrl = EndPoint.baseUrl;

      await consumer.get('jobs');
      expect(adapter.capturedUri.toString(), 'https://second.example/api/jobs');
    });

    test('the interceptor never overrides the centralized URL', () async {
      // --- Even with a different valid value cached, requests follow
      // --- EndPoint instead of any configuration-manager behavior. ---
      await preferencesService.saveApiBaseUrl('https://cached.example/api/');
      EndPoint.baseUrl = 'https://central.example/api/';

      await buildConsumer().get('jobs');

      expect(
        adapter.capturedUri.toString(),
        'https://central.example/api/jobs',
      );
    });

    test('token refresh follows the same centralized configuration', () async {
      EndPoint.baseUrl = 'https://central.example/api/';
      adapter = _CaptureAdapter(statusCode: 401);
      final consumer = buildConsumer();

      // --- No refresh token: interceptor logs out and forwards the 401
      // --- without creating a differently-configured Dio instance. ---
      await expectLater(consumer.get('jobs'), throwsA(isA<ServerException>()));
      expect(consumer.dio.options.baseUrl, 'https://central.example/api/');
    });
  });
}
