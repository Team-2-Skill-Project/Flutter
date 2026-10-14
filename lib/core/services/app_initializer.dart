import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:MatchIn/core/networking/api_end_points.dart';
import 'package:MatchIn/core/services/app_config_service.dart';
import 'package:MatchIn/core/services/push_notifications_service.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';

///* AppInitializer: single application bootstrap entry point.
///* Owns the startup sequence so main.dart stays minimal: Firebase,
///* centralized base-url resolution, Mobile Ads, background config
///* refresh, and push notifications. Every step degrades gracefully and
///* [init] never throws, so the app always reaches runApp().
Future<void> _defaultPushInitializer(SharedPreferencesService storage) {
  return PushNotificationsService.init(storage: storage);
}

Future<void> _defaultAdsInitializer() {
  return MobileAds.instance.initialize();
}

class AppInitializer {
  AppInitializer({
    required this.appConfigService,
    required this.sharedPreferencesService,
    required this.dio,
    this.pushInitializer,
    this.adsInitializer,
  });

  final AppConfigService appConfigService;
  final SharedPreferencesService sharedPreferencesService;
  final Dio dio;

  // --- Injectable startup hooks: static SDK singletons (FCM, Mobile Ads)
  // --- cannot run in unit tests, so tests inject fakes. Production uses
  // --- the defaults and behaves exactly as before. ---
  final Future<void> Function(SharedPreferencesService)? pushInitializer;
  final Future<void> Function()? adsInitializer;

  //! ===== Startup =====

  // --- Preserves the existing startup sequence and error handling ---
  Future<void> init() async {
    await _initFirebase();

    // --- Resolve synchronously before any API request can run ---
    _applyStartupBaseUrl();

    // --- Refresh and push setup never delay the first frame ---
    unawaited(refreshBaseUrl());
    unawaited(_initPushNotifications());

    await _initMobileAds();
  }

  //! ===== Runtime configuration =====

  // --- Explicit update mechanism: validated URL flows into the
  // --- centralized EndPoint and the live Dio instance. No recreation
  // --- of Dio and no configuration logic inside the interceptor. ---
  Future<void> refreshBaseUrl() async {
    try {
      final result = await appConfigService.refresh();
      result.fold((failure) => log('App config refresh: ${failure.message}'), (
        baseUrl,
      ) {
        EndPoint.baseUrl = baseUrl;
        dio.options.baseUrl = baseUrl;
        log('App config refresh: using $baseUrl');
      });
    } catch (e) {
      log('App config refresh error: $e');
    }
  }

  //! ===== Startup steps =====

  // --- Uses native google-services.json on Android; failures must not
  // --- prevent the app from starting. ---
  Future<void> _initFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      log('Firebase init error: $e');
    }
  }

  // --- Valid cache applies immediately; the central fallback covers
  // --- first launches while Firestore refreshes in the background. ---
  void _applyStartupBaseUrl() {
    EndPoint.baseUrl = appConfigService.currentBaseUrl;
  }

  // --- Initialized before runApp so RewardedAd.load() in the roadmap
  // --- feature never races an uninitialized SDK. ---
  Future<void> _initMobileAds() async {
    try {
      await (adsInitializer ?? _defaultAdsInitializer)();
    } catch (e) {
      log('MobileAds init error: $e');
    }
  }

  Future<void> _initPushNotifications() async {
    try {
      await (pushInitializer ?? _defaultPushInitializer)(
        sharedPreferencesService,
      );
    } catch (e) {
      log('Push notifications init error: $e');
    }
  }
}
