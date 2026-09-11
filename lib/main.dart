import 'package:MatchIn/app.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure the Flutter engine is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the service locator
  await setupServiceLocator();

  // Run the app
  runApp(const MatchIn());
}
