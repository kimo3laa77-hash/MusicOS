import 'engine_state.dart';

/// The base contract that every MusicOS engine must implement.
///
/// An engine encapsulates a single, self-contained infrastructure concern
/// (audio playback, metadata parsing, caching, etc.) and exposes a
/// consistent lifecycle to the rest of the application.
///
/// Engines are initialized and disposed exclusively by [EngineManager].
/// Feature code must never control an engine's lifecycle directly.
///
/// ### Lifecycle
///
/// ```
/// uninitialized → initializing → ready → running ⇄ paused → disposed
/// ```
///
/// - Call [initialize] once before using an engine.
/// - Call [dispose] when the engine is no longer needed.
/// - Inspect [state] to observe the current lifecycle position.
abstract interface class Engine {
  /// The current lifecycle state of this engine.
  EngineState get state;

  /// Prepares the engine for use.
  ///
  /// Transitions: [EngineState.uninitialized] → [EngineState.initializing]
  /// → [EngineState.ready] on success, or [EngineState.error] on failure.
  ///
  /// Calling [initialize] more than once on the same instance is undefined
  /// behaviour; implementors should guard against it.
  Future<void> initialize();

  /// Releases all resources held by this engine.
  ///
  /// After [dispose] completes the engine must be in [EngineState.disposed]
  /// and must not be used again.
  Future<void> dispose();
}
