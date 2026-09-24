import 'package:MatchIn/app.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupServiceLocator();

  // Run the app
  runApp(const MatchIn());
}