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
/// 4. Wrap everything — including [WidgetsFlutterBinding.ensureInitialized]
///    and [runApp] — in [runZonedGuarded] so both execute in the same Zone.
///    This is required by Flutter: the binding and runApp must share a Zone.
/// 5. Initialise the dependency injection container.
/// 6. Launch the widget tree inside a [ProviderScope].
///
/// [main.dart] has one responsibility: call this function.
void bootstrap() {
  // Everything runs inside a single Zone so that WidgetsFlutterBinding and
  // runApp are never in mismatched Zones (which produces a runtime warning).
  runZonedGuarded(
    () async {
      // 1. Binding must be the first call inside the guarded Zone.
      WidgetsFlutterBinding.ensureInitialized();

      // 2. Logger must be ready before anything else logs.
      AppLogger.init();
      AppLogger.info('MusicOS bootstrap started');

      // 3. Route Flutter framework errors (widget build failures, layout
      //    errors) through AppLogger instead of the default console dump.
      FlutterError.onError = GlobalErrorHandler.handleFlutterError;

      // 4. Initialise the dependency injection container.
      await configureDependencies();

      // 5. Launch the widget tree.
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

