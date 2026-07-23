/// Internal constants for all [SharedPreferences] keys used by [SettingsEngine].
///
/// These are the authoritative key names persisted to disk.
/// Never use raw string literals outside this file for settings keys.
///
/// New keys are added here only when a concrete feature requires them —
/// never speculatively.
abstract final class SettingsKeys {
  SettingsKeys._();

  // ── Library ────────────────────────────────────────────────────────────────

  /// Whether hidden files and folders are excluded during library scanning.
  ///
  /// Type: [bool]. Default: `true`.
  static const String ignoreHiddenFiles = 'settings.ignore_hidden_files';
}
