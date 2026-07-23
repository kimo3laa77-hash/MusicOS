import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/app.dart';
import '../core/di/injection.dart';
import '../core/logging/app_logger.dart';

/// Entry point for the full application startup sequence.
///
/// Responsibility (per Folder Structure doc §3 bootstrap/):
/// 1. Ensure Flutter bindings are initialised.
/// 2. Initialise the logger.
/// 3. Initialise the dependency injection container.
/// 4. Launch the widget tree inside a [ProviderScope].
///
/// [main.dart] has one responsibility: call this function.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.info('MusicOS bootstrap started');

  await configureDependencies();
  AppLogger.info('Dependency injection configured');

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );

  AppLogger.info('MusicOS bootstrap complete');
}
