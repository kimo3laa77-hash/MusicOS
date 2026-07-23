/// Coordinates the lifecycle of all registered [Engine] instances.
///
/// Lifecycle orchestration methods (`register`, `initializeAll`,
/// `disposeAll`) will be added together with the first concrete engine
/// implementation (Audio Engine sprint).
///
/// [EngineManager] will be registered as a singleton in the DI container
/// at that same point, once it has a real consumer and concrete context.
final class EngineManager {}
