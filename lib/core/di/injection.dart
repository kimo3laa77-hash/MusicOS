import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import '../engines/engine_manager.dart';
import '../engines/settings/settings_engine.dart';
import '../logging/app_logger.dart';
import '../services/app_path_provider.dart';

/// The application's global [GetIt] service locator.
///
/// Access the container via [getIt] throughout the application.
/// Features must never instantiate shared services manually; always resolve
/// them through [getIt] or a Riverpod provider backed by [getIt].
final GetIt getIt = GetIt.instance;

/// Initialises the dependency injection container.
///
/// Called once during [bootstrap] before the Flutter widget tree is built.
///
/// ### Registration order
///
/// Dependencies must be registered before anything that consumes them:
///
/// 1. **Database** — [AppDatabase] singleton.
/// 2. **Engines** — [EngineManager] and engines with no service dependencies.
/// 3. **Services** — [AppPathProvider], [SharedPreferences],
///    [FlutterSecureStorage].
/// 4. **Engine–Service bindings** — Engines that depend on services from
///    section 3 are constructed and registered here, after all services are
///    available. Each engine is also registered with [EngineManager].
///
/// ### AppLogger
///
/// [AppLogger] is intentionally **not** registered in GetIt.
/// It is a static utility class initialised in [bootstrap] before the DI
/// container is available, making registration both unnecessary and
/// impractical. Call [AppLogger] directly from any class.
///
/// ### Code generation
///
/// When the first [@injectable] / [@singleton] class is introduced, replace
/// this hand-written function with the generated initialiser from
/// `injection.config.dart` and run:
/// ```
/// flutter pub run build_runner build --delete-conflicting-outputs
/// ```
Future<void> configureDependencies() async {
  // ── 1. Database ────────────────────────────────────────────────────────────
  // [AppDatabase] is registered as a singleton so a single connection is
  // shared across the entire application. The constructor internally calls
  // driftDatabase(), which opens the SQLite file on a background isolate.
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  // ── 2. Engines ─────────────────────────────────────────────────────────────
  // [EngineManager] is the sole orchestrator of every engine lifecycle.
  // Registered eagerly here because it has no service dependencies.
  getIt.registerSingleton<EngineManager>(EngineManager());

  // ── 3. Services ────────────────────────────────────────────────────────────
  // Registered in dependency order. All three are singletons — instantiated
  // once and reused for the lifetime of the application.

  // Resolves platform directories once; consumers read paths synchronously.
  getIt.registerSingleton<AppPathProvider>(await AppPathProvider.init());

  // Lightweight key-value store for non-sensitive user preferences.
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // Encrypted key-value store for sensitive data (tokens, credentials).
  getIt.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );

  // ── 4. Engine–Service Bindings ────────────────────────────────────────────
  // Engines that depend on services registered in section 3 are constructed
  // here, after all service singletons are available. Each engine is
  // registered both in GetIt and with [EngineManager].

  final settingsEngine = SettingsEngine(prefs: getIt<SharedPreferences>());
  getIt.registerSingleton<SettingsEngine>(settingsEngine);
  getIt<EngineManager>().register(settingsEngine);

  AppLogger.info('Dependency injection configured');
}

