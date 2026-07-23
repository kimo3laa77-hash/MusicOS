# MusicOS Tech Stack

## 1. Technology Philosophy

The technology stack for MusicOS is selected with long-term stability, maintainability, and performance as the primary objectives.

Every technology must satisfy the following principles:

- Production Ready
- Well Maintained
- Large Community
- Excellent Documentation
- High Performance
- Long-Term Support
- Flutter First
- Cross-Platform Ready

Technology choices should prioritize proven solutions over experimental libraries.

### Selection Criteria

Every dependency should provide measurable value.

New dependencies should only be introduced when they:

- Solve a real problem.
- Improve maintainability.
- Improve developer productivity.
- Improve performance.
- Reduce complexity.

Dependencies should never be added simply because they are popular.

### Technology Principles

- Minimize external dependencies.
- Prefer official Flutter packages whenever possible.
- Prefer actively maintained open-source projects.
- Avoid unnecessary abstraction layers.
- Keep the stack simple and predictable.
- Every dependency should have a clear purpose.

The technology stack should remain stable throughout Version 1.0 unless a critical issue requires replacement.

---

## 2. Flutter SDK

MusicOS is built using the Flutter SDK.

Flutter is selected because it provides:

- High-performance native rendering
- Excellent developer experience
- Strong ecosystem
- Cross-platform capability
- Long-term support

### SDK Policy

- Always use the latest stable Flutter release.
- Do not use beta, dev, or master channels for production development.
- Keep the Flutter SDK updated only after verifying compatibility with all project dependencies.

### Platform Targets

Version 1.0 officially targets:

- Android

The architecture remains prepared for future support of:

- iOS
- Windows
- macOS
- Linux

Web is currently out of scope.

### Flutter Rules

- Use only stable Flutter APIs.
- Prefer official Flutter packages whenever possible.
- Avoid deprecated APIs.
- Follow Flutter's recommended project structure and best practices.

---

## 3. Programming Language

MusicOS is developed using Dart.

### Language Policy

- Use the latest stable Dart version supported by the selected Flutter SDK.
- Enable sound null safety.
- Follow the official Dart style guide.

### Coding Principles

- Prefer immutable objects.
- Use final wherever possible.
- Prefer const constructors.
- Avoid dynamic unless absolutely necessary.
- Favor expressive, type-safe APIs.

### Language Rules

- No legacy null safety.
- No unnecessary type casts.
- Avoid reflection.
- Prefer composition over inheritance.
- Keep code strongly typed.

---

## 4. State Management


MusicOS uses Riverpod as its official state management solution.

### Selected Technology

- flutter_riverpod
- riverpod_annotation
- riverpod_generator

### Why Riverpod

Riverpod is selected because it provides:

- Compile-time safety
- Testability
- Predictable state management
- Excellent scalability
- No dependency on BuildContext
- Strong ecosystem
- Officially recommended by the Flutter community

### Rules

- All application state must be managed through Riverpod.
- Business logic must remain outside the UI.
- Providers should have a single responsibility.
- Avoid unnecessary provider nesting.
- Prefer generated providers where appropriate.
- Keep state immutable whenever possible.

---

## 5. Routing

MusicOS uses GoRouter as its official navigation solution.

### Selected Technology

- go_router

### Why GoRouter

GoRouter is selected because it provides:

- Declarative routing
- Nested navigation support
- Deep linking
- ShellRoute
- Excellent Flutter integration
- Strong long-term maintainability

### Rules

- All navigation must use GoRouter.
- Avoid Navigator.push unless required internally by GoRouter.
- Feature routes should remain modular.
- Deep links must be supported.
- Navigation logic should remain outside UI widgets.

---

## 6. Local Database


MusicOS uses Drift as its official local database.

### Selected Technology

- drift
- drift_flutter
- drift_dev (dev dependency)
- sqlite3_flutter_libs

### Why Drift

Drift is selected because it provides:

- Actively maintained with a dedicated author and regular releases
- Type-safe, compile-time verified SQL queries
- First-class reactive queries via `.watch()` — integrates natively with Riverpod `StreamProvider`
- Background isolate support via `NativeDatabase.createInBackground()` for UI-thread safety
- SQLite WAL mode for concurrent reads and writes during background library scanning
- Full relational query support (JOINs, indexes, aggregations) required for a large music library
- Schema migrations with versioned callbacks and `SchemaVerifier` testing support
- Cross-platform: Android, iOS, Windows, macOS, Linux, and Web (WASM)
- Uses the same `build_runner` pipeline as Freezed and Riverpod — no tooling conflicts

### Rules

- All persistent application data must be stored in Drift.
- Business logic must never access Drift directly.
- Access to the database must occur only through repositories.
- Database table data classes must remain separate from domain entities.
- Freezed models serve as domain entities; Drift data classes serve as database models.
- Schema migrations must be versioned and documented.
- All heavy database operations must run on a background isolate.
- Enable WAL mode for all database instances to support concurrent access.


---

## 7. Audio Stack

MusicOS uses the following audio technologies:

### Selected Technologies

- just_audio
- audio_service
- audio_session

### Why This Stack

This combination provides:

- High-performance playback
- Background audio support
- Media notification controls
- Media session integration
- Audio focus management
- Queue management
- Cross-platform architecture

### Rules

- All playback must be managed by the Audio Engine.
- UI components must never communicate directly with just_audio.
- Background playback must be handled through audio_service.
- Audio focus should always be managed through audio_session.
- Future providers must integrate without modifying the Audio Engine interface.

---

## 8. Dependency Injection


MusicOS uses GetIt as its official dependency injection container.

### Selected Technologies

- get_it
- injectable

### Why This Stack

This combination provides:

- Centralized dependency registration
- Loose coupling
- Improved testability
- Scalable architecture
- Easy dependency replacement

### Rules

- All services must be registered through the DI container.
- Avoid creating dependencies manually inside features.
- Prefer constructor injection over service location where practical.
- Register dependencies in a single composition root.
- Mock implementations should be easily injectable during testing.

---

## 9. Networking

Version 1.0 of MusicOS is an offline-first application.

Networking is included only to prepare the architecture for future integrations.

### Selected Technologies

- dio

### Why Dio

Dio provides:

- Robust HTTP client
- Interceptors
- Request cancellation
- Timeout configuration
- File downloads
- Excellent Flutter support

### Rules

- Version 1.0 should not depend on network availability.
- All future network providers must use repository abstractions.
- Networking logic must remain isolated from business logic.
- Requests should support retry and timeout policies where appropriate.

---

## 10. Storage


MusicOS uses the following storage technologies:

### Selected Technologies

- flutter_secure_storage
- path_provider
- shared_preferences

### Why This Stack

Each technology has a specific responsibility:

- flutter_secure_storage → Sensitive data
- path_provider → File system locations
- shared_preferences → Small application preferences

### Rules

- Sensitive information must never be stored in SharedPreferences.
- Large data belongs in Drift or the file system.
- SharedPreferences should only store lightweight configuration values.
- File paths should always be obtained through path_provider.

---

## 11. Logging

MusicOS uses Logger as its official logging solution.

### Selected Technology

- logger

### Why Logger

Logger provides:

- Structured logging
- Configurable output
- Easy debugging
- Environment-based logging

### Rules

- Log important application events.
- Never log sensitive user information.
- Debug logs should be disabled in production builds.
- Logging should support future crash reporting integrations.

---

## 12. Testing

MusicOS uses Flutter's official testing framework.

### Selected Technologies

- flutter_test
- mocktail
- integration_test

### Why This Stack

This stack provides:

- Unit testing
- Widget testing
- Integration testing
- Mocking support
- Official Flutter compatibility

### Rules

- Business logic should be unit tested.
- UI should be widget tested where practical.
- Critical user journeys should have integration tests.
- Mocks should be used to isolate dependencies.

---

## 13. Code Generation

MusicOS uses code generation to reduce boilerplate while maintaining type safety.

### Selected Technologies

- build_runner
- freezed
- json_serializable
- riverpod_generator
- injectable_generator

### Why This Stack

These tools provide:

- Immutable models
- Union types
- JSON serialization
- Provider generation
- Dependency injection generation

### Rules

- Generated files must never be edited manually.
- Source files remain the single source of truth.
- Regenerate code after modifying annotated classes.

---

## 14. Development Tools

The following tools are used during development.

### Selected Tools

- flutter_lints
- dart format
- dart analyze
- git
- VS Code / Android Studio

### Rules

- Code must be formatted before commit.
- Analyzer warnings should be resolved.
- Lint rules should not be ignored without justification.
- Development tools should remain consistent across the team.

---

## 15. Package Selection Rules

External packages should be introduced only when they provide clear value.

### Selection Criteria

A package should:

- Be actively maintained.
- Have strong community adoption.
- Be well documented.
- Support null safety.
- Be compatible with the selected Flutter SDK.

### Evaluation

Before adding a new dependency, evaluate:

- Maintenance status
- License
- Performance impact
- Long-term viability
- Alternatives

### Rules

- Minimize dependencies.
- Remove unused packages promptly.
- Prefer official Flutter packages when suitable.
- Review dependencies periodically for updates and security fixes.










