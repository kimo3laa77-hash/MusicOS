import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

/// Root application widget.
///
/// Responsibilities:
/// - Wire [MaterialApp.router] with the [appRouter].
/// - Apply [AppTheme.light] and [AppTheme.dark].
/// - Default to [ThemeMode.dark] (primary MusicOS theme).
///
/// No business logic lives here. Navigation, theming, and DI are the
/// only concerns of this widget.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'MusicOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
