import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Centralised logging wrapper around the [Logger] package.
///
/// Usage:
/// ```dart
/// AppLogger.info('Library scan started');
/// AppLogger.error('Playback failed', error: e, stackTrace: st);
/// ```
///
/// In debug builds a [PrettyPrinter] is used for human-readable output.
/// In release builds a [SimplePrinter] is used to minimise overhead.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: kDebugMode
        ? PrettyPrinter(lineLength: 100)
        : SimplePrinter(),
    level: kDebugMode ? Level.trace : Level.warning,
  );

  /// Verbose trace-level message. Use only during heavy debugging.
  static void trace(String message) => _logger.t(message);

  /// Debug-level message. Disabled in release builds.
  static void debug(String message) => _logger.d(message);

  /// Informational message for significant application events.
  static void info(String message) => _logger.i(message);

  /// Warning for unexpected but non-fatal situations.
  static void warning(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  /// Error for failures that affect functionality.
  static void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  /// Fatal — unrecoverable application error.
  static void fatal(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}
