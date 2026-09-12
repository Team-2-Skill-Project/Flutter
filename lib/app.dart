import 'package:MatchIn/core/routing/app_router.dart';
import 'package:MatchIn/core/theme/dark_theme.dart';
import 'package:MatchIn/core/theme/light_theme.dart' as theme;
import 'package:MatchIn/core/utils/app_constants.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchIn extends StatelessWidget {
  const MatchIn({super.key});

  @override
  Widget build(BuildContext context) {
    //=== screenUtil init for responsive design ===
    return ScreenUtilInit(
      //TODO: change design size
      designSize: const Size(390, 845),
      minTextAdapt: true,
      splitScreenMode: true,

      // === Material App with router ===
      child: MaterialApp.router(
        // === language ===
        locale: const Locale(AppConstants.languageCode),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        // === debug banner ===
        debugShowCheckedModeBanner: false,

        // === theme ===
        theme: theme.lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,

        // === router ===
        routerConfig: AppRouter.router,
      ),
    );
  }
}
