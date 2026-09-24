import 'package:MatchIn/app.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  // Run the app
  runApp(const MatchIn());
}