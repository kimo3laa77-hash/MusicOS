import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_placeholder_screen.dart';

/// Application router.
///
/// Sprint 1.3: A single `/` route pointing at [HomePlaceholderScreen].
/// Feature routes (library, search, player, settings) are registered here
/// as each feature is implemented in later sprints.
///
/// Exposed as a Riverpod [Provider] so it can be watched by [App] and
/// overridden in tests without modifying production code.
final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePlaceholderScreen(),
      ),
    ],
  ),
);
