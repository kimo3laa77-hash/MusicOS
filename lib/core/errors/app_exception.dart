/// Base sealed class for all application-level failures.
///
/// Rules (from Architecture doc §8):
/// - Raw platform exceptions must never reach the UI.
/// - Every layer converts lower-level errors into [AppException] subtypes.
/// - The UI receives only [AppException] subtypes — never raw [Exception] or [Error].
///
/// New subtypes are added as features are implemented.
sealed class AppException implements Exception {
  const AppException({required this.message, this.cause});

  /// Human-readable description of the failure (for logging, not UI display).
  final String message;

  /// The underlying exception that caused this failure, if any.
  final Object? cause;

  @override
  String toString() => cause != null
      ? '$runtimeType: $message (caused by: $cause)'
      : '$runtimeType: $message';
}

// ─────────────────────────────────────────────────────────────────────────────
// Infrastructure subtypes
// ─────────────────────────────────────────────────────────────────────────────

/// Thrown when the DI container, app configuration, or any other startup
/// step fails in a predictable, diagnosable way.
///
/// Distinct from [UnexpectedException], which wraps unknown runtime errors.
final class InitializationException extends AppException {
  const InitializationException({required super.message, super.cause});
}

/// Wraps any unexpected exception that has not been mapped to a specific
/// [AppException] subtype yet.
final class UnexpectedException extends AppException {
  const UnexpectedException({required super.message, super.cause});
}

