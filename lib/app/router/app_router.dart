import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_placeholder_screen.dart';
import 'error_placeholder_screen.dart';

/// Application router.
///
/// Navigation architecture:
/// - A flat [GoRoute] list is used for now.
/// - [ShellRoute] and the bottom navigation shell are introduced in the sprint
///   that implements the main navigation scaffold (post-Sprint 2.1).
///
/// [errorBuilder] is wired to [ErrorPlaceholderScreen] so navigation
/// failures display a structured error view rather than a raw stack trace.
///
/// Exposed as a Riverpod [Provider] so it can be watched by [App] and
/// overridden in tests without modifying production code.
final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    errorBuilder: (context, state) =>
        ErrorPlaceholderScreen(error: state.error),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePlaceholderScreen(),
      ),
    ],
  ),
);

