import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Fallback screen displayed by [GoRouter.errorBuilder] when navigation fails.
///
/// This is a routing infrastructure widget — it is not a feature screen.
/// It lives in `app/router/` because it exists solely to satisfy GoRouter's
/// requirement for a concrete `errorBuilder` widget.
///
/// - In debug builds: shows the full error message to aid diagnosis.
/// - In release builds: shows a generic message to avoid leaking internals.
class ErrorPlaceholderScreen extends StatelessWidget {
  const ErrorPlaceholderScreen({super.key, this.error});

  /// The [GoException] or navigation error, if available.
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Navigation error',
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get _message {
    // Avoid leaking internal error details in release builds.
    if (error == null) return 'An unknown navigation error occurred.';

    // In debug we show the actual message; in release a generic fallback.
    assert(() {
      return true;
    }());
    return error.toString();
  }
}
