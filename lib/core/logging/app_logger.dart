import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Centralised logging wrapper around the [Logger] package.
///
/// Call [AppLogger.init] once at the top of [bootstrap] before any other
/// component attempts to log. All subsequent calls are safe to make from
/// any isolate or zone.
///
/// Usage:
/// ```dart
/// AppLogger.init();
/// AppLogger.info('Library scan started');
/// AppLogger.error('Playback failed', error: e, stackTrace: st);
/// ```
///
/// In debug builds a [PrettyPrinter] is used for human-readable output.
/// In release builds a [SimplePrinter] is used to minimise overhead.
class AppLogger {
  AppLogger._();

  static late Logger _logger;

  // ── Initialisation ─────────────────────────────────────────────────────────

  /// Initialises the logger.
  ///
  /// Must be called once during [bootstrap] before any other log call.
  /// Subsequent calls are no-ops.
  static bool _initialised = false;

  static void init() {
    if (_initialised) return;
    _logger = Logger(
      printer: kDebugMode ? PrettyPrinter(lineLength: 100) : SimplePrinter(),
      level: kDebugMode ? Level.trace : Level.warning,
    );
    _initialised = true;
  }

  // ── Log levels ─────────────────────────────────────────────────────────────

  /// Verbose trace-level message. Use only during heavy debugging.
  static void trace(String message) => _logger.t(message);

  /// Debug-level message. Disabled in release builds.
  static void debug(String message) => _logger.d(message);

  /// Informational message for significant application events.
  static void info(String message) => _logger.i(message);

  /// Warning for unexpected but non-fatal situations.
  static void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  /// Error for failures that affect functionality.
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  /// Fatal — unrecoverable application error.
  static void fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.f(message, error: error, stackTrace: stackTrace);

  // ── Flutter integration ────────────────────────────────────────────────────

  /// Routes a [FlutterErrorDetails] through [AppLogger].
  ///
  /// Called by [GlobalErrorHandler.handleFlutterError] so that widget-layer
  /// failures appear in the same structured log output as application errors.
  static void logFlutterError(FlutterErrorDetails details) {
    fatal(
      'Flutter framework error: ${details.exceptionAsString()}',
      error: details.exception,
      stackTrace: details.stack,
    );
  }
}

