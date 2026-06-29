import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/app/router.dart';
import 'package:hedwig_client/app/theme/theme_controller.dart';

class HedwigApp extends ConsumerWidget {
  const HedwigApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Hedwig',
      themeMode: themeMode,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    var colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1565C0),
      brightness: brightness,
    );
    if (brightness == Brightness.dark) {
      // Default M3 dark surfaces sit near-black; lift them to softer greys so
      // the UI reads as "dark" without being pitch black.
      colorScheme = colorScheme.copyWith(
        surface: const Color(0xFF26262B),
        surfaceDim: const Color(0xFF26262B),
        surfaceBright: const Color(0xFF3D3D43),
        surfaceContainerLowest: const Color(0xFF202024),
        surfaceContainerLow: const Color(0xFF2A2A2F),
        surfaceContainer: const Color(0xFF2E2E33),
        surfaceContainerHigh: const Color(0xFF36363B),
        surfaceContainerHighest: const Color(0xFF3F3F45),
      );
    }
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
