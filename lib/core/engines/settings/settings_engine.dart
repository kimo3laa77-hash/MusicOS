import 'package:shared_preferences/shared_preferences.dart';

import '../engine.dart';
import '../engine_state.dart';
import '../../logging/app_logger.dart';
import 'settings_keys.dart';

/// The Settings Engine — the single source of truth for all application
/// preferences backed by [SharedPreferences].
///
/// ### Lifecycle
///
/// [SettingsEngine] follows the standard [Engine] lifecycle managed by
/// [EngineManager]:
///
/// ```
/// uninitialized → initializing → ready → disposed
/// ```
///
/// Call [initialize] (via [EngineManager.initializeAll]) before reading or
/// writing settings in production code. Reading preferences before
/// [initialize] is technically possible because [SharedPreferences] is
/// pre-loaded, but it should not be relied upon.
///
/// ### Usage
///
/// ```dart
/// final settings = getIt<SettingsEngine>();
/// final ignored = settings.ignoreHiddenFiles; // read
/// await settings.setIgnoreHiddenFiles(false);  // write
/// ```
///
/// ### Extensibility
///
/// New preferences are added by:
/// 1. Declaring a key constant in [SettingsKeys].
/// 2. Adding a typed getter and mutator pair in this class.
///
/// No other files need to change.
final class SettingsEngine implements Engine {
  /// Creates a [SettingsEngine] with the given [SharedPreferences] instance.
  ///
  /// The [prefs] dependency is injected by the DI container — this class
  /// never resolves [SharedPreferences] from [GetIt] internally.
  SettingsEngine({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;
  EngineState _state = EngineState.uninitialized;

  // ── Engine contract ────────────────────────────────────────────────────────

  @override
  EngineState get state => _state;

  /// Prepares the engine for use.
  ///
  /// [SharedPreferences] is pre-loaded by the Flutter plugin; no async I/O
  /// is required here. The method transitions through [EngineState.initializing]
  /// immediately to [EngineState.ready].
  ///
  /// Calling [initialize] more than once is a no-op after the first call.
  @override
  Future<void> initialize() async {
    if (_state != EngineState.uninitialized) return;
    _state = EngineState.initializing;
    _state = EngineState.ready;
    AppLogger.info('SettingsEngine initialized');
  }

  /// Releases any resources held by this engine and marks it as disposed.
  ///
  /// After [dispose] the engine must not be used again.
  @override
  Future<void> dispose() async {
    _state = EngineState.disposed;
    AppLogger.info('SettingsEngine disposed');
  }

  // ── Library settings ───────────────────────────────────────────────────────

  /// Whether hidden files and folders are excluded during library scanning.
  ///
  /// Defaults to `true` when no value has been persisted.
  bool get ignoreHiddenFiles =>
      _prefs.getBool(SettingsKeys.ignoreHiddenFiles) ?? true;

  /// Persists the [value] for [ignoreHiddenFiles].
  Future<void> setIgnoreHiddenFiles(bool value) =>
      _prefs.setBool(SettingsKeys.ignoreHiddenFiles, value);
}
