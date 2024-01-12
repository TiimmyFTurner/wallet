import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';
import 'package:wallet/infrastructure/router.dart';
import 'package:wallet/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  return runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String? font =
        Platform.localeName.substring(0, 2) == "fa" ? 'Koodak' : null;
    final ColorScheme defaultScheme =
        ColorScheme.fromSeed(seedColor: Colors.lightBlue);
    final ColorScheme defaultDarkScheme = ColorScheme.fromSeed(
        seedColor: Colors.lightBlue, brightness: Brightness.dark);
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp.router(
        routerConfig: router,
        title: 'Mini Wallet',
        theme: ThemeData(
            colorScheme: lightColorScheme ?? defaultScheme,
            useMaterial3: true,
            fontFamily: font),
        darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? defaultDarkScheme,
            useMaterial3: true,
            fontFamily: font),
        themeMode: ThemeMode.system,
        supportedLocales: L10n.all,
        // locale: const Locale('fa'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
