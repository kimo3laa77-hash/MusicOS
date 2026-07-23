import 'package:flutter/foundation.dart';

import '../logging/app_logger.dart';

/// Centralised handler for uncaught application errors.
///
/// Two static methods are registered during [bootstrap]:
///
/// - [handleFlutterError] is assigned to [FlutterError.onError] so that
///   widget-layer failures (build exceptions, layout overflows in release
///   mode) are routed through [AppLogger] instead of the default console dump.
///
/// - [handleZonedError] is passed to [runZonedGuarded] as the uncaught-error
///   callback, catching any unhandled [Future] or [Stream] errors that escape
///   the normal try/catch hierarchy.
///
/// Keeping this logic here rather than inline in [bootstrap] makes it
/// independently testable without spinning up the full widget tree.
abstract final class GlobalErrorHandler {
  GlobalErrorHandler._();

  // ── Flutter error handler ──────────────────────────────────────────────────

  /// Handles errors thrown by the Flutter framework (widget build failures,
  /// rendering errors, etc.).
  ///
  /// In debug builds the error is also forwarded to
  /// [FlutterError.presentError] so the red error widget still appears,
  /// preserving the normal development feedback loop.
  ///
  /// In release builds only logging occurs — the red widget is suppressed.
  static void handleFlutterError(FlutterErrorDetails details) {
    AppLogger.logFlutterError(details);

    if (kDebugMode) {
      // Re-present so the in-app red error overlay still shows during
      // development. This is intentionally called after logging so the
      // log entry always appears even if presentError throws.
      FlutterError.presentError(details);
    }
  }

  // ── Zone error handler ─────────────────────────────────────────────────────

  /// Handles errors that escape [runZonedGuarded] — typically uncaught
  /// [Future] rejections or [Stream] errors that propagate to the root zone.
  static void handleZonedError(Object error, StackTrace stackTrace) {
    AppLogger.fatal(
      'Uncaught zone error: $error',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
