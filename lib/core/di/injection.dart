import 'package:get_it/get_it.dart';

import '../logging/app_logger.dart';

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
/// 1. **Database** — [AppDatabase] singleton (Sprint 2.2).
/// 2. **Engines** — Audio, Metadata, Cache, Settings, etc. (Sprint 2.2+).
/// 3. **Services** — Permission, FilePicker, Connectivity, etc. (Sprint 2.2+).
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
  // AppDatabase singleton registered in Sprint 2.2.

  // ── 2. Engines ─────────────────────────────────────────────────────────────
  // Engine registrations added as each engine is implemented (Sprint 2.2+).

  // ── 3. Services ────────────────────────────────────────────────────────────
  // Shared service registrations added as services are introduced.

  AppLogger.info('Dependency injection configured');
}

