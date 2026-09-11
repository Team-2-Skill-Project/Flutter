import 'package:MatchIn/app.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  runApp(const MatchIn());
}
