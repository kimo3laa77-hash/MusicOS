# MusicOS Architecture

## 1. Architecture Foundation

MusicOS is designed as a long-term software platform rather than a traditional mobile application.

The architecture prioritizes scalability, maintainability, extensibility, performance, and developer experience above all else.

MusicOS follows a Feature-First Clean Architecture, where every feature is developed as an independent module with clear boundaries and responsibilities.

The architecture is built around the following principles:

- Clean Architecture
- Feature-First Organization
- Offline-First Design
- Engine-Based Core
- Provider Pattern
- Repository Pattern
- Dependency Injection
- SOLID Principles
- Reactive Programming
- Single Source of Truth

### Core Philosophy

The application is not built around screens.

It is built around independent engines that provide reusable capabilities.

Screens display data.

Features coordinate user interactions.

Engines execute business logic.

Providers supply data.

Repositories abstract data sources.

### Architecture Goals

The architecture must:

- Be easy to understand.
- Be easy to extend.
- Be easy to maintain.
- Be easy to test.
- Support future streaming providers.
- Support future desktop platforms.
- Support plugins without architectural changes.

Every major component must have one responsibility.

Every dependency must point in one direction.

Business logic must remain independent from Flutter.

Platform-specific code must remain isolated.

No feature may directly depend on another feature.

Communication between features must happen only through contracts and shared abstractions.

This architecture is intended to support MusicOS for many years without requiring large-scale refactoring.

## 2. High-Level Architecture

MusicOS is composed of six primary architectural domains.

Each domain has a clearly defined responsibility and communicates with the rest of the system through well-defined contracts.

The six domains are:

### 1. Features

Features represent everything the user interacts with.

Each feature is self-contained and owns its Presentation, Application, Domain, and Data layers.

Examples include:

- Home
- Search
- Library
- Player
- Settings

Features must never communicate directly with each other.

---

### 2. Core

Core contains reusable infrastructure shared across the entire application.

Examples include:

- Theme
- Logging
- Error Handling
- Common Utilities
- Shared Models
- Constants
- Extensions
- Shared Services

Core must remain independent from every feature.

---

### 3. Engines

Engines contain the application's complex business logic.

Every engine has a single responsibility.

Examples include:

- Audio Engine
- Search Engine
- Metadata Engine
- Cache Engine
- Theme Engine
- Analytics Engine

Engines are reusable and can be consumed by multiple features.

---

### 4. Providers

Providers supply music and metadata to the application.

The rest of the application never communicates with external sources directly.

Every provider implements the same contract.

Examples include:

- Local Provider
- YouTube Music Provider (future)
- Spotify Provider (future)

Adding a new provider must not require changes to existing features.

---

### 5. Data Sources

Data Sources represent physical storage or external systems.

Examples include:

- Isar Database
- File System
- Shared Preferences
- Secure Storage

Repositories abstract all interaction with Data Sources.

---

### 6. Platform

Platform contains Android-specific integrations.

Examples include:

- Audio Focus
- Notifications
- Media Session
- Storage Access Framework
- Background Services
- Permissions

Platform-specific code must never leak into business logic.

---

These six domains together form the complete MusicOS architecture.

Every new feature added to the project must integrate into one of these domains without changing the architectural foundation.

## 3. System Layers

Every feature inside MusicOS follows the same internal architecture.

Each feature is divided into four independent layers.

Dependencies always flow downward.

A layer may only communicate with the layer directly below it.

---

### Presentation Layer

Purpose:

Responsible for everything the user sees and interacts with.

Contains:

- Screens
- Widgets
- Components
- Navigation
- Theme Integration
- Animations

Responsibilities:

- Display UI
- Listen to state changes
- Dispatch user actions

Rules:

- No business logic
- No database access
- No provider access
- No file system access

---

### Application Layer

Purpose:

Coordinates application behavior.

Contains:

- Controllers
- Riverpod Providers
- State Management
- Commands
- User Actions

Responsibilities:

- Receive user interactions
- Coordinate use cases
- Manage UI state
- Handle workflows

Rules:

- No UI rendering
- No direct database access
- No direct file access
- No platform APIs

---

### Domain Layer

Purpose:

Contains the business rules of the feature.

Contains:

- Entities
- Use Cases
- Repository Contracts
- Provider Contracts
- Business Rules

Responsibilities:

- Define application behavior
- Validate business logic
- Remain platform independent

Rules:

- Pure Dart only
- No Flutter imports
- No Android imports
- No Isar imports
- No UI dependencies

The Domain Layer is the heart of every feature.

---

### Data Layer

Purpose:

Implements everything required by the Domain Layer.

Contains:

- Repository Implementations
- Provider Implementations
- Local Data Sources
- Remote Data Sources
- Database Access
- File System Access
- Metadata Readers

Responsibilities:

- Read data
- Write data
- Convert models into domain entities
- Hide implementation details

Rules:

- Never expose raw database models
- Never expose provider-specific models
- Always return Domain Entities

---

### Layer Communication

Presentation

↓

Application

↓

Domain

↓

Data

Only downward communication is allowed.

No layer may skip another layer.

No feature may bypass repositories.

Business logic must never leave the Domain Layer.

This structure must remain identical across every feature in the application.

## 4. Core Engines

Core Engines are the foundation of MusicOS.

Unlike Features, Engines are completely UI-independent.

An Engine provides reusable capabilities that can be consumed by any feature without creating direct dependencies.

Every Engine must have one responsibility.

Every Engine must expose a clean public interface.

Engines never communicate directly with UI components.

---

### Audio Engine

Responsible for:

- Audio playback
- Queue management
- Playback state
- Background playback
- Media session
- Audio focus
- Shuffle
- Repeat
- Gapless playback

The Audio Engine is the heart of MusicOS.

No feature may implement playback logic outside the Audio Engine.

---

### Search Engine

Responsible for:

- Local search
- Provider search
- Search ranking
- Search history
- Search suggestions
- Search filters

The Search Engine provides one unified search interface regardless of where the music comes from.

---

### Metadata Engine

Responsible for:

- Reading metadata
- Album artwork extraction
- Lyrics extraction
- Artist information
- Album information
- Metadata normalization

It converts raw metadata into a unified internal representation.

---

### Cache Engine

Responsible for:

- Memory cache
- Disk cache
- Artwork cache
- Metadata cache
- Cache invalidation
- Cache cleanup

The Cache Engine optimizes performance without changing business logic.

---

### Theme Engine

Responsible for:

- Dynamic colors
- AMOLED mode
- Material You integration
- Theme persistence
- Typography
- Design tokens

The Theme Engine guarantees visual consistency across the application.

---

### Analytics Engine

Responsible for:

- Listening statistics
- Play counts
- Recently played
- Most played
- Listening history
- User insights

This engine only processes local application data.

---

### Settings Engine

Responsible for:

- User Preferences
- Theme Settings
- Playback Settings
- Library Settings
- Application Configuration
- Settings Persistence

The Settings Engine acts as the single source of truth for all application settings.

---

### Provider Engine

Responsible for:

- Provider Registration
- Provider Discovery
- Provider Lifecycle
- Provider Communication
- Provider Health Monitoring

The Provider Engine manages all music providers.

Features never communicate directly with providers.

Every provider must be registered through the Provider Engine.

The Provider Engine exposes a unified interface for the rest of the application.

---

### Platform Engine

Responsible for:

- Media Session
- Audio Focus
- Notifications
- Storage Access Framework
- Permissions
- Background Services

The Platform Engine isolates all platform-specific functionality from the rest of the application.

Business logic must never communicate directly with platform APIs.

---

### Engine Rules

Every Engine:


- Has one responsibility.
- Is reusable.
- Is independently testable.
- Is platform independent whenever possible.
- Exposes only public contracts.
- Never depends on UI.
- Never depends on Features.
- Never accesses another Engine directly unless explicitly defined through contracts.

New Engines may be added in future versions without modifying existing Engines.

---

### Engine Lifecycle

Every Engine follows the same lifecycle:

Initialize

↓

Ready

↓

Running

↓

Paused (optional)

↓

Disposed

Engines are created only once during application startup unless explicitly designed otherwise.

Features never control an Engine's lifecycle directly.

---

### Engine Communication

Engines communicate only through contracts.

No Engine may directly manipulate another Engine's internal state.

Shared events should flow through application-level abstractions.

This ensures loose coupling and long-term maintainability.

---

## 5. Feature Modules

This section defines the official architecture for all feature modules in MusicOS.

Each feature is an independent module following the same internal architecture:

- Presentation
- Application
- Domain
- Data

Each feature owns its own business logic and never accesses another feature directly.

The initial Version 1.0 feature modules are:

### Home

Responsibilities:

- Dashboard
- Continue Listening
- Recently Played
- Recommendations
- Quick Access

---

### Search

Responsibilities:

- Search UI
- Instant Search
- Search Filters
- Search History
- Search Suggestions

---

### Library

Responsibilities:

- Songs
- Albums
- Artists
- Genres
- Playlists
- Folder Browser
- Favorites
- Downloads

---

### Player

Responsibilities:

- Mini Player
- Full Player
- Queue UI
- Lyrics
- Playback Controls
- Sleep Timer

The Player Feature never performs playback itself.

It communicates only with the Audio Engine.

---

### Settings

Responsibilities:

- Application Settings
- Theme
- Playback Preferences
- Library Settings
- Backup & Restore
- Diagnostics

---

## Feature Rules

Every feature:

- Owns its own Presentation, Application, Domain and Data layers.
- May use Core.
- May use Engines.
- May use Repository Contracts.
- May never communicate directly with another Feature.
- Must remain independently testable.
- Must remain independently maintainable.

New features can be added without modifying existing feature modules.

---

## 6. Provider Architecture

This section defines the official Provider Architecture used throughout MusicOS.

The Provider system allows MusicOS to support multiple music sources through a unified interface.

Features never communicate directly with any music source.

Every Provider implements the same contract, ensuring that the rest of the application remains completely independent of the underlying source.

---

### Provider Contract

Every Provider must implement a common interface.

The interface must support, at minimum:

- Initialize
- Dispose
- Search
- Get Track
- Get Album
- Get Artist
- Get Playlist
- Get Stream
- Get Artwork
- Get Lyrics (optional)
- Get Recommendations (future)

The application communicates only with this contract.

---

### Built-in Providers

Version 1.0 includes:

- Local Provider

Future versions may add:

- YouTube Music Provider
- Spotify Provider
- Apple Music Provider
- Tidal Provider
- Plugin Providers

Adding a new provider must never require changes to existing Features or Engines.

---

### Provider Registration

Every Provider must register itself through the Provider Engine.

The Provider Engine is responsible for:

- Registration
- Initialization
- Availability
- Health Monitoring
- Lifecycle Management

Features must never instantiate Providers directly.

---

### Provider Communication

All communication between Features and Providers flows through:

Feature

↓

Repository

↓

Provider Engine

↓

Provider

Features never know which Provider is serving the request.

---

### Provider Lifecycle

Each Provider follows the same lifecycle:

Registered

↓

Initialized

↓

Ready

↓

Serving Requests

↓

Disposed

The lifecycle is managed exclusively by the Provider Engine.

---

### Provider Switching

The architecture must support switching Providers without changing Feature code.

For example:

Search → Local Provider

Later:

Search → Local Provider + YouTube Music Provider

The Search Feature remains unchanged.

Only the Provider configuration changes.

---

### Provider Isolation

Each Provider operates independently.

A failure in one Provider must never affect the operation of another Provider.

If a Provider becomes unavailable:

- The Provider Engine reports its status.
- Other Providers continue operating normally.
- Features receive a graceful fallback response.

---

### Future Plugin Support

The Provider Architecture is designed to support external plugins.

Every plugin must implement the official Provider Contract.

Once registered, a plugin behaves exactly like any built-in Provider.

No architectural changes should be required to support future Providers.

---

## 7. Data Flow

This section defines the official data flow throughout MusicOS.

MusicOS follows a strict unidirectional data flow.

Data always moves in one direction.

No component may bypass the defined architecture.

---

### User Interaction Flow

Every user action follows the same path:

User

↓

Presentation Layer

↓

Application Layer

↓

Domain Layer

↓

Repository

↓

Provider Engine

↓

Provider

↓

Data Source

The response follows the exact reverse path back to the UI.

---

### Audio Playback Flow

When a user presses Play:

Player Feature

↓

Audio Engine

↓

Provider Engine

↓

Provider

↓

Audio Stream

↓

Audio Engine

↓

Playback State

↓

Presentation Layer

Only the Audio Engine controls playback.

---

### Search Flow

When a user performs a search:

Search Feature

↓

Search Engine

↓

Provider Engine

↓

Available Providers

↓

Merged Results

↓

Ranking

↓

Presentation Layer

The Search Feature never communicates directly with Providers.

---

### Metadata Flow

Metadata always passes through the Metadata Engine.

Raw Metadata

↓

Metadata Engine

↓

Normalized Metadata

↓

Repository

↓

Feature

All Features receive the same normalized metadata structure regardless of the original source.

---

### Cache Flow

Whenever data is requested:

Feature

↓

Repository

↓

Cache Engine

↓

Cache Available?

Yes → Return Cached Data

No

↓

Provider

↓

Cache Result

↓

Return Data

The Cache Engine is transparent to Features.

---

### State Flow

State is immutable.

Every state update creates a new state.

Presentation observes state changes.

Business logic never updates UI directly.

---

### Error Flow

Errors always move upward.

Platform

↓

Provider

↓

Repository

↓

Domain

↓

Application

↓

Presentation

Every layer may transform errors into higher-level abstractions.

The UI never receives raw platform exceptions.

---

### Data Flow Rules

- Data always moves in one direction.
- Business logic never skips layers.
- UI never communicates with Providers.
- UI never communicates with Engines directly.
- Every request passes through Repositories.
- Every response returns Domain Entities.
- State updates are immutable.
- Features remain unaware of implementation details.

---

## 8. Engineering Rules

This section defines the mandatory engineering rules for every part of MusicOS.

These rules are non-negotiable and apply to every Feature, Engine, Provider, Repository, and Service.

---

### Architecture Rules

- Every module must have a single responsibility.
- No circular dependencies are allowed.
- Features must never communicate directly with each other.
- Business logic belongs only in the Domain Layer or Core Engines.
- Flutter is only responsible for presentation.

---

### Dependency Rules

Dependencies always point downward.

Allowed dependency direction:

Presentation

↓

Application

↓

Domain

↓

Data

↓

Core

No layer may bypass another layer.

---

### Repository Rules

Repositories are the only gateway to data.

Repositories hide:

- Database
- File System
- Providers
- Cache

Features must never access these directly.

---

### Engine Rules

Every Engine:

- Has one responsibility.
- Is independently testable.
- Exposes only public contracts.
- Never depends on UI.
- Never depends on Features.

---

### Provider Rules

Every Provider:

- Implements the official Provider Contract.
- Registers through the Provider Engine.
- Remains isolated from other Providers.
- Can be replaced without changing Feature code.

---

### Performance Rules

- Avoid unnecessary rebuilds.
- Prefer lazy loading.
- Cache expensive operations.
- Never block the UI thread.
- Optimize for smooth scrolling and responsive interactions.

---

### Error Handling Rules

- Never expose raw exceptions to the UI.
- Convert platform errors into domain failures.
- Every failure must be recoverable whenever possible.
- Log errors centrally.

---

### Testing Rules

Every Feature should support:

- Unit Tests
- Repository Tests
- Engine Tests
- Widget Tests

Business logic should be testable without Flutter.

---

### Future Scalability

Every architectural decision must support future expansion.

Adding:

- New Features
- New Engines
- New Providers
- Desktop Platforms
- Cloud Synchronization

must require minimal architectural changes.

---

### Final Principle

Performance is a feature.

Maintainability is a requirement.

Architecture comes before implementation.

User experience always takes priority over unnecessary complexity.









