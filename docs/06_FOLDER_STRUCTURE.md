# MusicOS Folder Structure

## 1. Folder Structure Philosophy

The MusicOS folder structure is designed to mirror the system architecture.

Every directory has a single responsibility.

Folders are organized by feature first, then by architectural layer.

The primary goals of the folder structure are:

- Readability
- Scalability
- Maintainability
- Discoverability
- Consistency

The structure must make it easy for any developer to locate code without prior knowledge of the project.

### Core Principles

- Feature-first organization.
- Clear separation of responsibilities.
- Low coupling between modules.
- High cohesion within modules.
- Predictable file locations.
- Consistent naming conventions.

Every folder should answer one question:

"What responsibility does this folder own?"

If the answer is unclear, the structure should be reconsidered.

### Rules

- Every directory has a single purpose.
- Avoid generic folders such as `misc`, `temp`, or `helpers`.
- Shared functionality belongs in `core` or `shared`, never inside unrelated features.
- Features must never contain code belonging to another feature.
- Folder names must remain stable as the project grows.
- The structure must support future expansion without major reorganization.

The folder structure is considered part of the architecture and must evolve only through intentional architectural decisions.

## 2. Root Directory

The root directory contains only top-level folders and files required for the project.

Every item at the root has a clearly defined purpose.

The root structure is as follows:

- android/
- assets/
- docs/
- lib/
- test/
- .github/
- .vscode/
- pubspec.yaml
- analysis_options.yaml
- README.md
- LICENSE
- CHANGELOG.md

### Responsibilities

#### android/

Contains all Android platform-specific configuration and native integration.

Flutter business logic must never be implemented here.

---

#### assets/

Contains all static application resources.

Examples:

- Images
- Icons
- Fonts
- Animations
- Lottie Files
- Audio Assets
- Placeholder Artwork

Assets must be organized into dedicated subdirectories.

---

#### docs/

Contains all project documentation.

Examples:

- Vision
- PRD
- Information Architecture
- Design System
- Architecture
- Folder Structure
- Development Guide

Documentation must remain version-controlled.

---

#### lib/

Contains the complete Flutter application source code.

All application logic resides inside this directory.

---

#### test/

Contains automated tests.

Examples:

- Unit Tests
- Widget Tests
- Integration Tests

Tests should mirror the structure of the lib directory whenever possible.

---

#### .github/

Contains GitHub workflows, issue templates, pull request templates, and repository automation.

---

#### .vscode/

Contains workspace-specific editor settings.

No project logic belongs here.

---

### Root Rules

- Avoid unnecessary files in the root directory.
- Every root folder must have a documented responsibility.
- Build artifacts must never be committed.
- Documentation is stored only inside the docs directory.

---

## 3. The lib Directory

The `lib` directory contains the complete Flutter application.

Every source file belongs somewhere inside this directory.

The top-level structure of `lib` is intentionally small and stable.

```
lib/
│
├── app/
├── core/
├── features/
├── shared/
├── bootstrap/
└── main.dart
```

### app/

Contains global application configuration.

Examples:

- App widget
- Router
- Theme configuration
- Dependency Injection
- Global Providers
- Navigation configuration

This directory initializes the application but contains no feature-specific business logic.

---

### bootstrap/

Responsible for starting the application.

Responsibilities include:

- Environment initialization
- Dependency registration
- Database initialization
- Engine initialization
- Provider initialization
- Error handling setup
- Logging initialization

The application should always start through the bootstrap layer.

---

### core/

Contains reusable infrastructure used throughout the application.

Core is completely independent from Features.

Examples include:

- Engines
- Services
- Utilities
- Theme
- Database
- Cache
- Logging
- Error Handling
- Constants
- Extensions

---

### features/

Contains every independent feature module.

Each feature owns its Presentation, Application, Domain, and Data layers.

Examples:

- home
- search
- library
- player
- settings

Features never contain shared infrastructure.

---

### shared/

Contains reusable UI components and models that are shared between multiple features.

Examples:

- Shared Widgets
- Dialogs
- Bottom Sheets
- Common Components
- Shared Models
- Shared Value Objects

Nothing inside `shared` should contain business logic.

---

### main.dart

The only responsibility of `main.dart` is to invoke the bootstrap process.

It should remain extremely small.

No application initialization logic should live inside `main.dart`.

---

### lib Rules

- Keep the top-level structure small.
- Every directory has a documented responsibility.
- Shared code belongs in `core` or `shared`.
- Business logic belongs inside Features or Core Engines.
- Avoid creating unnecessary top-level directories.
- New directories require architectural justification.

---

## 4. Core Directory

The `core` directory contains reusable infrastructure shared across the entire application.

Nothing inside `core` belongs to a specific feature.

Every module inside `core` has a single responsibility.

The structure is as follows:

```
core/
│
├── engines/
├── database/
├── cache/
├── theme/
├── services/
├── errors/
├── logging/
├── constants/
├── extensions/
├── utils/
└── di/
```

### engines/

Contains all reusable application engines.

Examples:

- Audio Engine
- Search Engine
- Metadata Engine
- Cache Engine
- Theme Engine
- Analytics Engine
- Provider Engine
- Platform Engine
- Settings Engine

No UI code belongs here.

---

### database/

Contains database initialization, schemas, migrations, adapters, and repositories' database helpers.

The rest of the application should never communicate directly with the database.

---

### cache/

Contains memory cache, disk cache, cache policies, cache managers, and artwork caching.

---

### theme/

Contains:

- Color System
- Typography
- Spacing
- Shapes
- Elevation
- Material Theme
- Dynamic Colors

The entire application's appearance is defined here.

---

### services/

Contains reusable services shared across multiple features.

Examples:

- Permission Service
- File Picker Service
- Connectivity Service

Services must remain independent from Features.

---

### errors/

Contains application-wide failures, exceptions, and error abstractions.

Raw platform exceptions should never leave this directory.

---

### logging/

Contains centralized logging.

Supports:

- Debug Logs
- Analytics Logs
- Error Logs

---

### constants/

Contains global immutable constants.

No magic values should exist elsewhere.

---

### extensions/

Contains Dart extension methods.

Extensions must remain generic and reusable.

---

### utils/

Contains small helper utilities.

Utilities must be stateless.

Business logic is not allowed here.

---

### di/

Contains Dependency Injection configuration.

All application dependencies are registered here.

No feature should manually instantiate shared services.

---

### Core Rules

- Core must never depend on Features.
- Every module has one responsibility.
- Shared infrastructure belongs here.
- UI must never exist inside Core.
- Core APIs should remain stable.

---

## 5. Features Directory

The `features` directory contains every independent feature module in MusicOS.

Each feature is completely self-contained.

Every feature follows the exact same internal structure.

The standard feature structure is:

```
feature/
│
├── presentation/
├── application/
├── domain/
└── data/
```

---

### presentation/

Contains everything related to the user interface.

Examples:

- Screens
- Widgets
- Components
- Dialogs
- Bottom Sheets
- Animations
- UI-specific State

Responsibilities:

- Render UI
- Observe state
- Dispatch user actions

Business logic is not allowed.

---

### application/

Coordinates application workflows.

Contains:

- Controllers
- Riverpod Providers
- State Management
- Commands
- Actions

Responsibilities:

- Connect UI with Domain
- Coordinate Use Cases
- Manage feature state

---

### domain/

Contains the business rules.

Contains:

- Entities
- Value Objects
- Repository Contracts
- Provider Contracts
- Use Cases

Rules:

- Pure Dart
- Platform Independent
- No Flutter imports

---

### data/

Implements the contracts defined by the Domain.

Contains:

- Repository Implementations
- Local Data Sources
- Remote Data Sources
- DTOs
- Mappers

Responsibilities:

- Read and write data
- Convert external models into Domain Entities

---

### Initial Feature Modules

Version 1.0 contains:

```
features/
│
├── home/
├── search/
├── library/
├── player/
└── settings/
```

Each feature follows the same internal architecture.

No feature may introduce a custom folder structure.

---

### Feature Rules

- Features own their business logic.
- Features never communicate directly with other Features.
- Shared functionality belongs in `core` or `shared`.
- Every Feature is independently testable.
- Every Feature is independently maintainable.
- Every Feature must follow the same architectural conventions.

---

## 6. Shared Directory

The `shared` directory contains reusable components that are used across multiple features but do not belong to the Core infrastructure.

Unlike `core`, the `shared` directory is primarily UI-focused.

The structure is as follows:

```
shared/
│
├── widgets/
├── dialogs/
├── bottom_sheets/
├── components/
├── models/
└── value_objects/
```

---

### widgets/

Contains reusable UI widgets shared across multiple features.

Examples:

- Buttons
- Cards
- App Bars
- Loading Indicators
- Empty States
- Error Views

Widgets must remain generic and configurable.

---

### dialogs/

Contains reusable dialog components.

Examples:

- Confirmation Dialog
- Delete Dialog
- Permission Dialog
- Error Dialog

Dialogs should contain presentation only.

---

### bottom_sheets/

Contains reusable bottom sheet components.

Examples:

- Queue Sheet
- Track Options Sheet
- Album Options Sheet

Bottom sheets should never contain business logic.

---

### components/

Contains reusable UI building blocks.

Examples:

- Album Card
- Artist Tile
- Track Tile
- Playlist Card

Components are shared presentation elements.

---

### models/

Contains models shared across multiple features when they do not belong to a single feature.

These models must remain lightweight and framework-independent.

---

### value_objects/

Contains reusable immutable value objects shared across the application.

Examples:

- Duration
- File Size
- Color Palette

---

### Shared Rules

- Shared contains no business logic.
- Shared never depends on Features.
- Shared components must be reusable.
- Presentation only.
- Generic before specific.

---

## 7. Assets Directory

The `assets` directory contains all static resources used by MusicOS.

Assets are organized by type to improve discoverability and maintainability.

The structure is as follows:

```
assets/
│
├── images/
├── icons/
├── fonts/
├── animations/
├── lottie/
├── placeholders/
├── audio/
└── themes/
```

---

### images/

Contains static application images.

Examples:

- Backgrounds
- Logos
- Illustrations

---

### icons/

Contains custom icon assets.

Material Icons should be preferred whenever possible.

---

### fonts/

Contains all custom font families used by the application.

Typography is managed centrally through the Theme Engine.

---

### animations/

Contains animation assets.

Examples:

- Rive
- Vector animations

---

### lottie/

Contains Lottie animation files.

---

### placeholders/

Contains fallback artwork and placeholder images.

Examples:

- Unknown Artist
- Unknown Album
- Missing Artwork

---

### audio/

Contains bundled application audio.

Examples:

- UI Sounds
- Notification Sounds

Music files are never stored here.

---

### themes/

Contains theme-related assets.

Examples:

- Default palettes
- Theme resources

---

### Asset Rules

- Assets are grouped by type.
- File names use snake_case.
- Assets must be optimized before inclusion.
- Duplicate assets are not allowed.
- Unused assets should be removed regularly.

---

## 8. Test Directory

The `test` directory mirrors the structure of the `lib` directory.

Every major module should have corresponding tests.

The structure is as follows:

```
test/
│
├── core/
├── features/
├── shared/
└── integration/
```

### Core Tests

Contains tests for:

- Engines
- Services
- Cache
- Database
- Theme
- Utilities

---

### Feature Tests

Each Feature should mirror its structure:

```
features/
└── player/
    ├── presentation/
    ├── application/
    ├── domain/
    └── data/
```

---

### Shared Tests

Contains tests for reusable widgets and shared components.

---

### Integration Tests

Contains end-to-end application tests.

Examples:

- App startup
- Library scan
- Search
- Playback
- Queue management

---

### Test Rules

- Tests mirror the production folder structure.
- Business logic must always be testable.
- New Features should include tests from the beginning.
- Test files follow the same naming convention as production files with the `_test` suffix.

---

## 9. Naming Conventions

Consistent naming is mandatory throughout MusicOS.

The following conventions apply to every directory, file, class, variable, method, and asset.

---

### Directories

Directory names use:

- snake_case
- lowercase only

Examples:

- audio_engine
- player
- library
- shared_widgets

---

### Files

File names use:

- snake_case
- lowercase only

Examples:

- audio_engine.dart
- player_controller.dart
- track_repository.dart

---

### Classes

Classes use:

- PascalCase

Examples:

- AudioEngine
- TrackRepository
- PlayerController
- SearchUseCase

---

### Variables

Variables use:

- camelCase

Examples:

- currentTrack
- playbackState
- searchResults

---

### Methods

Methods use:

- camelCase
- verb-first naming

Examples:

- playTrack()
- pausePlayback()
- loadLibrary()
- searchSongs()

---

### Constants

Compile-time constants use:

- lowerCamelCase for Dart constants
- SCREAMING_SNAKE_CASE only when required by platform integrations or generated code.

Examples:

- defaultAnimationDuration
- maxCacheSize

---

### Assets

Asset files use:

- snake_case

Examples:

- default_album.png
- play_icon.svg
- splash_background.webp

---

### Naming Rules

- Names must clearly describe responsibility.
- Avoid abbreviations unless universally understood.
- Avoid generic names like helper, util, temp, data2, manager_new.
- Prefer descriptive names over short names.
- Similar concepts should follow consistent naming patterns.

---

## 10. File Organization Rules

This section defines the mandatory rules for organizing source files throughout MusicOS.

These rules ensure that the project remains clean, predictable, and maintainable as it grows.

---

### Single Responsibility

Every file must have one clear responsibility.

If a file begins serving multiple unrelated purposes, it should be split into smaller files.

---

### File Size

Source files should remain reasonably small.

Large files are difficult to understand, review, and maintain.

If a file grows significantly, it should be refactored into smaller components.

---

### Folder Ownership

Every file belongs to exactly one folder.

Files must never be duplicated across multiple locations.

---

### Import Rules

Imports should always follow the architectural boundaries.

Features must never import internal implementation details from other Features.

Only public contracts may be imported across module boundaries.

---

### Shared Code

Reusable code belongs in either:

- `core`
- `shared`

Feature-specific code must never be moved into shared locations unless it is genuinely reusable.

---

### Feature Isolation

Every Feature owns its:

- Presentation
- Application
- Domain
- Data

No Feature may modify another Feature's internal implementation.

---

### Engine Isolation

Engines remain independent from Features.

Features consume Engine contracts but never manage Engine lifecycles.

---

### Repository Ownership

Repositories are responsible for coordinating:

- Local Data Sources
- Remote Data Sources
- Providers
- Cache

No other layer should coordinate these responsibilities.

---

### Documentation

Major architectural changes must always be reflected in the documentation.

The documentation is considered part of the project and should evolve alongside the source code.

---

### Final Folder Structure Principles

- Consistency is more important than personal preference.
- Simplicity is preferred over clever organization.
- The folder structure should scale naturally without frequent restructuring.
- Every new folder requires a clear architectural reason.
- Developers should be able to locate any file quickly based on responsibility alone.









