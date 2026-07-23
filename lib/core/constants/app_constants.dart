/// Global application constants.
///
/// All magic values that are referenced across more than one file must be
/// declared here. No feature-specific constants belong in this file.
///
/// Database constants ([databaseName], [databaseVersion]) are declared now so
/// that Sprint 2.2 can reference them without modifying this file.
abstract final class AppConstants {
  AppConstants._();

  // ── Application ────────────────────────────────────────────────────────────

  /// Human-readable application name used in the window title, About screen,
  /// and any platform-level system UI (e.g., Android task manager).
  static const String appName = 'MusicOS';

  // ── Database ───────────────────────────────────────────────────────────────

  /// File name of the SQLite database created by Drift.
  ///
  /// Centralised here to prevent mismatches between production code and tests.
  /// Referenced by `AppDatabase` in Sprint 2.2.
  static const String databaseName = 'musicos.db';

  /// Current schema version.
  ///
  /// Increment this value whenever a schema migration is added.
  /// Referenced by `AppDatabase.schemaVersion` in Sprint 2.2.
  static const int databaseVersion = 1;
}
