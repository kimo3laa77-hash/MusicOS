import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/app.dart';
import '../core/di/injection.dart';
import '../core/errors/global_error_handler.dart';
import '../core/logging/app_logger.dart';

/// Entry point for the full application startup sequence.
///
/// Responsibility (per Folder Structure doc §3 bootstrap/):
/// 1. Ensure Flutter bindings are initialised.
/// 2. Initialise the logger.
/// 3. Override [FlutterError.onError] so widget-layer errors are logged.
/// 4. Wrap the remaining startup in [runZonedGuarded] so uncaught async
///    errors are captured and logged rather than silently dropped.
/// 5. Initialise the dependency injection container.
/// 6. Launch the widget tree inside a [ProviderScope].
///
/// [main.dart] has one responsibility: call this function.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Logger must be ready before anything else logs.
  AppLogger.init();
  AppLogger.info('MusicOS bootstrap started');

  // 2. Route Flutter framework errors (widget build failures, layout errors)
  //    through AppLogger instead of the default console dump.
  FlutterError.onError = GlobalErrorHandler.handleFlutterError;

  // 3. Catch any uncaught async errors that escape normal try/catch boundaries.
  await runZonedGuarded(
    () async {
      await configureDependencies();

      runApp(
        const ProviderScope(
          child: App(),
        ),
      );

      AppLogger.info('MusicOS bootstrap complete');
    },
    GlobalErrorHandler.handleZonedError,
  );
}

