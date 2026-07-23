import 'package:flutter/material.dart';

/// Defines the application's visual theme.
///
/// MusicOS uses a dark-first Material 3 design system. The dark theme is the
/// primary experience; the light theme is provided for completeness.
///
/// Design tokens (colors, typography, spacing) that are referenced across
/// multiple files will be extracted into dedicated files (`app_colors.dart`,
/// `app_text_styles.dart`) when the Theme Engine is introduced in a later
/// sprint. For now, all tokens live here to keep Sprint 2.1 focused.
///
/// Usage:
/// ```dart
/// MaterialApp.router(
///   theme: AppTheme.light(),
///   darkTheme: AppTheme.dark(),
///   themeMode: ThemeMode.dark,
/// )
/// ```
abstract final class AppTheme {
  AppTheme._();

  // ── Seed colour ────────────────────────────────────────────────────────────

  /// Deep violet — evokes premium audio equipment and dark studio environments.
  static const Color _seed = Color(0xFF5B4FCF);

  /// Near-black surface for an AMOLED-friendly dark experience.
  static const Color _darkSurface = Color(0xFF0A0A0A);

  // ── Public theme factories ─────────────────────────────────────────────────

  /// Light [ThemeData]. Provided for completeness; MusicOS defaults to dark.
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(seedColor: _seed);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: _appBarTheme(scheme),
      cardTheme: _cardTheme(scheme),
      listTileTheme: _listTileTheme(scheme),
      navigationBarTheme: _navigationBarTheme(scheme),
    );
  }

  /// Dark [ThemeData]. This is the primary theme for MusicOS.
  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
      surface: _darkSurface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _darkSurface,
      appBarTheme: _appBarTheme(scheme),
      cardTheme: _cardTheme(scheme),
      listTileTheme: _listTileTheme(scheme),
      navigationBarTheme: _navigationBarTheme(scheme),
    );
  }

  // ── Component themes ───────────────────────────────────────────────────────

  static AppBarTheme _appBarTheme(ColorScheme scheme) => AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
      );

  static CardThemeData _cardTheme(ColorScheme scheme) => CardThemeData(
        color: scheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.zero,
      );

  static ListTileThemeData _listTileTheme(ColorScheme scheme) =>
      ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: scheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );

  static NavigationBarThemeData _navigationBarTheme(ColorScheme scheme) =>
      NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      );
}

