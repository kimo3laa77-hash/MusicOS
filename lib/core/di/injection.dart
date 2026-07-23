import 'package:get_it/get_it.dart';

/// The application's global [GetIt] service locator.
///
/// Access the container via [getIt] or through Riverpod providers — never
/// instantiate services manually inside feature code.
final GetIt getIt = GetIt.instance;

/// Initialises the dependency injection container.
///
/// Called once during [bootstrap] before the Flutter widget tree is built.
///
/// Sprint 1.3: No services are registered yet. The function body is
/// intentionally empty and safe to call. Registrations are added as
/// engines and services are introduced in Phase 2.
///
/// When the first [@injectable] / [@singleton] class is added, run:
/// ```
/// flutter pub run build_runner build --delete-conflicting-outputs
/// ```
/// and replace this hand-written function with the generated
/// `injection.config.dart` initialiser.
Future<void> configureDependencies() async {
  // Registrations will be added here in Phase 2.
}
