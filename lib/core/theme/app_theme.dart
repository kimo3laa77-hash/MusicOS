import 'package:flutter/material.dart';

/// Defines the application's visual theme.
///
/// This is a placeholder implementation for Sprint 1.3.
/// Dynamic colours, Material You integration, and full design token system
/// are introduced in the Theme Engine (Phase 2 / Sprint 2.x).
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
  // Placeholder value — will be replaced by the Theme Engine's dynamic palette.
  static const Color _seed = Color(0xFF6750A4); // Material 3 default purple

  /// Light [ThemeData]. Placeholder — full design system comes in Phase 2.
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
        ),
      );

  /// Dark [ThemeData]. This is the primary theme for MusicOS.
  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
        ),
      );
}
