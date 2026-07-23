/// Represents the full lifecycle state of a [Engine].
///
/// Every engine transitions through these states in a well-defined order:
///
/// ```
/// uninitialized → initializing → ready → running ⇄ paused → disposed
///                                                          ↘ error
/// ```
enum EngineState {
  /// Default state. [Engine.initialize] has not been called yet.
  uninitialized,

  /// [Engine.initialize] has been called and is currently in progress.
  initializing,

  /// Initialization completed successfully. The engine is available but not
  /// yet actively processing work.
  ready,

  /// The engine is actively processing (e.g. audio is playing, a scan is
  /// in progress). Transitions to [paused] or [disposed].
  running,

  /// The engine has been temporarily suspended. A transition back to
  /// [running] is valid when processing resumes.
  paused,

  /// [Engine.dispose] has been called. The engine is no longer usable and
  /// must not be restarted.
  disposed,

  /// An unrecoverable failure occurred during initialization or at runtime.
  /// The engine cannot proceed and must be considered unusable.
  error,
}
