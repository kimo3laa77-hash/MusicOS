import 'engine.dart';

/// Coordinates the lifecycle of all registered [Engine] instances.
///
/// ### Registration order
///
/// Engines should be registered in dependency order — engines that others
/// depend on must be registered first. [disposeAll] reverses the registration
/// order automatically, ensuring dependents are torn down before their
/// dependencies.
///
/// ### Lifecycle
///
/// 1. Call [register] for each engine during DI setup (inside
///    `configureDependencies`).
/// 2. Call [initializeAll] once during bootstrap, after DI is complete.
/// 3. Call [disposeAll] when the application is terminating (e.g. inside
///    an `AppLifecycleObserver` — wired in a future sprint).
final class EngineManager {
  final List<Engine> _engines = [];

  /// Registers [engine] with this manager.
  ///
  /// Must be called before [initializeAll].
  /// Engines are initialised in registration order.
  void register(Engine engine) => _engines.add(engine);

  /// Initialises all registered engines in registration order.
  Future<void> initializeAll() async {
    for (final engine in _engines) {
      await engine.initialize();
    }
  }

  /// Disposes all registered engines in reverse registration order.
  Future<void> disposeAll() async {
    for (final engine in _engines.reversed) {
      await engine.dispose();
    }
  }
}
