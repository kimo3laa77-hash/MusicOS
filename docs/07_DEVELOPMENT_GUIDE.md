# MusicOS Development Guide

## 1. Development Philosophy

MusicOS is developed as a long-term software platform.

Every development decision must prioritize long-term maintainability over short-term convenience.

The objective is to build a stable, scalable, and predictable codebase that can evolve for many years.

### Core Principles

Development follows these principles:

- Architecture before implementation.
- Simplicity over cleverness.
- Readability over brevity.
- Performance by design.
- Offline-first development.
- Testability by default.
- Incremental delivery.
- Continuous refactoring.
- Documentation-driven development.

### Development Mindset

Every feature should be:

- Small
- Independent
- Testable
- Maintainable
- Replaceable

Developers should focus on building reliable systems rather than simply adding features.

### Engineering Values

Every change should improve at least one of the following:

- Readability
- Stability
- Performance
- User Experience
- Maintainability

Code should never become more complex without a measurable benefit.

### Long-Term Vision

MusicOS is expected to evolve continuously.

Every implementation should assume that:

- New Features will be added.
- New Providers will be integrated.
- Desktop platforms will eventually be supported.
- Cloud synchronization will be introduced.
- Existing modules will continue to evolve.

The codebase should welcome change rather than resist it.

### Development Rules

- Never violate the architecture.
- Never bypass repositories.
- Never duplicate business logic.
- Never optimize prematurely.
- Always document architectural decisions.
- Always leave the project cleaner than you found it.

The goal is not only to deliver features, but to continuously improve the overall quality of the project.

---

## 2. Project Roadmap

Development follows an incremental, milestone-based roadmap.

Each milestone delivers a stable and functional improvement to the application.

Every milestone must end with a working application.

Features should never be partially integrated into the main branch.

---

### Milestone 1 — Project Foundation

Objectives:

- Create Flutter project
- Configure project structure
- Setup Riverpod
- Configure GoRouter
- Configure Drift
- Configure Dependency Injection
- Setup Logging
- Setup Theme
- Setup Documentation

Deliverable:

A clean project foundation with no feature implementation.

---

### Milestone 2 — Core Infrastructure

Objectives:

- Audio Engine
- Provider Engine
- Settings Engine
- Platform Engine
- Metadata Engine
- Cache Engine

Deliverable:

Core infrastructure fully operational and independently testable.

---

### Milestone 3 — Library

Objectives:

- Folder Selection
- Library Scan
- Metadata Reading
- Album Artwork
- Database Storage

Deliverable:

Users can build and browse a local music library.

---

### Milestone 4 — Playback

Objectives:

- Queue
- Mini Player
- Full Player
- Background Playback
- Notifications
- Media Session
- Gapless Playback

Deliverable:

Music playback is fully functional.

---

### Milestone 5 — Search

Objectives:

- Instant Search
- Filters
- Search History
- Suggestions
- Ranking

Deliverable:

Users can quickly locate music from their library.

---

### Milestone 6 — Home

Objectives:

- Dashboard
- Continue Listening
- Recently Played
- Favorites
- Quick Actions

Deliverable:

The Home experience is complete.

---

### Milestone 7 — Settings

Objectives:

- Theme
- Dynamic Colors
- Cache Management
- Backup & Restore
- Diagnostics

Deliverable:

Application configuration is complete.

---

### Milestone 8 — Polish

Objectives:

- Animations
- Performance Optimization
- Accessibility
- Bug Fixes
- UX Improvements
- Documentation Review

Deliverable:

Version 1.0 Release Candidate.

---

### Release 1.0

The application is considered ready for release only when:

- All milestones are completed.
- Performance goals are achieved.
- Documentation is complete.
- Automated tests pass.
- No critical issues remain.

---

## 3. Development Workflow

MusicOS is developed using an iterative and feature-driven workflow.

Development always follows the same sequence to ensure consistency and quality.

No feature may skip any stage.

---

### Standard Workflow

Every feature follows this lifecycle:

Requirements

↓

Architecture Review

↓

UI Design

↓

Domain Design

↓

Implementation

↓

Testing

↓

Code Review

↓

Documentation Update

↓

Merge

---

### Feature Development

Each feature must be developed independently.

The recommended order is:

1. Define requirements.
2. Create or update documentation.
3. Implement Domain.
4. Implement Data.
5. Implement Application.
6. Implement Presentation.
7. Write tests.
8. Review performance.
9. Update documentation.
10. Merge into the main development branch.

---

### Incremental Development

Features should be delivered in small increments.

Avoid implementing multiple unrelated features simultaneously.

Every completed increment should leave the application in a stable, runnable state.

---

### Refactoring

Refactoring is encouraged throughout development.

Refactoring must not change observable behavior unless explicitly intended.

Architectural improvements should be documented.

---

### Workflow Rules

- Never merge unfinished features.
- Never skip testing.
- Never bypass architecture.
- Keep changes focused and small.
- Every commit should move the project forward.

---

## 4. Git Workflow

MusicOS uses a Git-based workflow designed for stability, traceability, and clean project history.

Every change should be committed through a consistent development process.

---

### Branches

The project uses the following primary branches:

- main
- develop

Feature work should be completed in dedicated feature branches.

Examples:

- feature/library
- feature/player
- feature/search
- feature/settings

---

### Feature Branch Workflow

The standard workflow is:

develop

↓

feature/<feature_name>

↓

Code Review

↓

Merge into develop

↓

Release

↓

main

---

### Commit Messages

Commit messages should be concise and descriptive.

Preferred format:

type(scope): description

Examples:

- feat(player): implement queue management
- fix(search): resolve ranking issue
- refactor(audio): simplify playback state
- docs(architecture): update provider section
- test(library): add repository tests

---

### Merge Rules

- Merge only completed features.
- Resolve conflicts before merging.
- Ensure tests pass before merge.
- Documentation must be updated before merge.

---

### Git Rules

- Never commit generated build files.
- Never commit secrets or API keys.
- Keep commits focused on a single purpose.
- Prefer multiple small commits over one large commit.
- Maintain a clean and understandable Git history.

---

## 5. Branch Strategy

MusicOS follows a simple and scalable branching strategy.

Every branch has a clearly defined purpose.

---

### main

The production-ready branch.

Rules:

- Always stable.
- Always releasable.
- Never commit directly.
- Updated only through reviewed merges.

---

### develop

The primary development branch.

Rules:

- Integrates completed features.
- Should remain stable.
- Acts as the source for future releases.

---

### feature/*

Used for implementing individual features.

Examples:

- feature/player
- feature/search
- feature/library
- feature/settings

Rules:

- One feature per branch.
- Branch from `develop`.
- Merge back into `develop`.

---

### hotfix/*

Used only for critical production fixes.

Examples:

- hotfix/playback-crash
- hotfix/database-migration

Rules:

- Branch from `main`.
- Merge into both `main` and `develop`.

---

### release/*

Optional release preparation branches.

Examples:

- release/v1.0.0

Responsibilities:

- Final testing
- Documentation review
- Version updates
- Bug fixes

---

### Branch Rules

- Never develop directly on `main`.
- Keep feature branches short-lived.
- Delete merged feature branches.
- Use descriptive branch names.
- Every merge should leave the target branch stable.

---

## 6. Coding Standards

This section defines the official coding standards for MusicOS.

Consistency is more important than personal preference.

All contributors should follow the same conventions.

---

### General Principles

- Write readable code.
- Prefer clarity over cleverness.
- Keep functions small and focused.
- Prefer composition over inheritance.
- Avoid unnecessary abstraction.
- Keep business logic independent from UI.

---

### Naming

Follow the naming conventions defined in the Folder Structure documentation.

Names should clearly describe their responsibility.

Avoid abbreviations unless universally understood.

---

### File Organization

Each file should have a single responsibility.

Large files should be split into smaller components.

Avoid mixing unrelated classes in the same file.

---

### Functions

Functions should:

- Perform one task.
- Have descriptive names.
- Avoid excessive nesting.
- Return early when appropriate.
- Be easy to test.

Avoid long functions whenever possible.

---

### Classes

Classes should:

- Have one responsibility.
- Depend on abstractions.
- Be independently testable.
- Avoid unnecessary state.

Large classes should be decomposed into smaller components.

---

### Comments

Code should be self-explanatory whenever possible.

Use comments to explain:

- Architectural decisions.
- Non-obvious logic.
- Complex algorithms.

Do not use comments to explain obvious code.

---

### Error Handling

Never ignore exceptions.

Handle failures explicitly.

Convert infrastructure errors into domain failures before exposing them to higher layers.

---

### Code Quality

Every change should improve one or more of:

- Readability
- Maintainability
- Performance
- Testability
- Consistency

Avoid introducing technical debt.

---

### Coding Rules

- Avoid duplicated logic.
- Prefer immutable data.
- Minimize side effects.
- Keep dependencies explicit.
- Follow the established architecture.
- Refactor when necessary.

---

## 7. State Management Guidelines

MusicOS uses Riverpod as its official state management solution.

State management must remain predictable, testable, and independent of the UI.

---

### Principles

- Single Source of Truth.
- Immutable State.
- Reactive Updates.
- Minimal State.
- Explicit State Changes.

---

### Responsibilities

Presentation:

- Observe state.
- Dispatch actions.

Application:

- Coordinate state changes.
- Expose providers.

Domain:

- Execute business rules.

Data:

- Provide data.

---

### Provider Rules

Providers should:

- Have one responsibility.
- Expose immutable state.
- Avoid unnecessary rebuilds.
- Remain independently testable.

---

### State Rules

Only store state that the UI truly needs.

Avoid duplicated state.

Derived values should be computed rather than stored.

---

### Async State

Loading, Success, and Error states should be represented explicitly.

UI must always be capable of rendering each state.

---

### State Management Rules

- Never mutate state directly.
- Prefer immutable models.
- Keep providers small.
- Avoid global mutable state.
- Dispose resources correctly.

---

## 8. Testing Strategy

Testing is an integral part of the MusicOS development process.

Every feature should be designed with testability in mind from the beginning.

Testing is not an optional phase added after implementation.

---

### Testing Levels

MusicOS uses multiple levels of testing:

- Unit Tests
- Widget Tests
- Integration Tests

Each level has a specific purpose.

---

### Unit Tests

Unit tests verify business logic in isolation.

Examples:

- Use Cases
- Domain Services
- Repository Logic
- Core Engines
- Utility Functions

Unit tests should not depend on Flutter UI.

---

### Widget Tests

Widget tests verify UI behavior.

Examples:

- Screen rendering
- Button interactions
- State changes
- Loading states
- Error states

---

### Integration Tests

Integration tests verify complete application workflows.

Examples:

- First launch
- Folder selection
- Library scan
- Search
- Playback
- Queue management
- Settings persistence

---

### Test Coverage

Priority should be given to testing:

- Business logic
- Critical user flows
- Core infrastructure

Visual details do not require exhaustive testing.

---

### Testing Rules

- New features should include tests.
- Bugs should be accompanied by regression tests whenever practical.
- Tests should be deterministic.
- Tests should remain fast.
- Failing tests block merges.

---

## 9. Code Review Checklist

Every code change should be reviewed before being merged.

The purpose of code review is to improve quality, maintain consistency, and reduce defects.

---

### Architecture

Verify that:

- The architecture is respected.
- Layer boundaries are maintained.
- No forbidden dependencies exist.
- Business logic remains in the correct layer.

---

### Code Quality

Verify that:

- Code is readable.
- Functions are small and focused.
- Classes have a single responsibility.
- Naming follows project conventions.
- No unnecessary complexity has been introduced.

---

### Performance

Verify that:

- No unnecessary rebuilds occur.
- Expensive operations are optimized.
- UI remains responsive.
- Memory usage is reasonable.

---

### Testing

Verify that:

- Appropriate tests exist.
- Existing tests pass.
- New behavior is covered when practical.
- No existing functionality has regressed.

---

### Documentation

Verify that:

- Documentation has been updated if architecture or behavior changed.
- Public APIs remain documented.
- Comments explain only non-obvious decisions.

---

### Review Rules

- Reviews should focus on improving the project, not personal coding style.
- Feedback should be constructive and actionable.
- Large changes should be broken into smaller reviews whenever possible.
- No code should be merged without review, even for solo development. Use the checklist as a self-review before merging.

---

## 10. Performance Guidelines

Performance is a core feature of MusicOS.

Every implementation should prioritize smooth interaction, low latency, and efficient resource usage.

---

### General Principles

- Optimize only when necessary, but design with performance in mind.
- Avoid premature optimization that harms readability.
- Measure performance before making optimization decisions.

---

### UI Performance

The UI should:

- Maintain smooth scrolling.
- Avoid unnecessary rebuilds.
- Use lazy loading where appropriate.
- Keep animations responsive.
- Minimize layout recalculations.

---

### Audio Performance

The Audio Engine should:

- Respond instantly to playback controls.
- Keep playback uninterrupted.
- Minimize CPU usage during playback.
- Efficiently manage background execution.

---

### Memory Management

The application should:

- Dispose unused resources.
- Cache only when beneficial.
- Prevent memory leaks.
- Limit artwork memory usage.
- Release large objects promptly.

---

### Database Performance

Database operations should:

- Use indexes appropriately.
- Avoid unnecessary queries.
- Batch operations whenever possible.
- Keep search latency low.

---

### Search Performance

Search should:

- Return results instantly.
- Scale efficiently with large libraries.
- Avoid blocking the UI thread.

---

### Background Work

Long-running tasks should execute asynchronously.

Examples:

- Library scanning
- Metadata extraction
- Artwork processing
- Cache cleanup

---

### Performance Rules

- Never block the main UI thread.
- Profile before optimizing.
- Optimize the critical user journey first.
- Maintain responsiveness under heavy workloads.

---

## 11. Security Guidelines

Security is a fundamental quality attribute of MusicOS.

Every feature should be implemented with privacy, data protection, and secure coding practices in mind.

---

### User Privacy

MusicOS is a local-first application.

User data remains on the device unless the user explicitly enables future cloud or third-party integrations.

No personal data should be collected without user consent.

---

### Secure Storage

Sensitive information should be stored using secure platform storage whenever applicable.

Examples include:

- Authentication tokens
- API credentials
- Encryption keys

---

### Permissions

Request only the permissions required for the current feature.

Explain clearly why each permission is needed before requesting it.

Avoid requesting unnecessary permissions.

---

### Data Protection

The application should:

- Validate all external inputs.
- Handle corrupted or unexpected data safely.
- Prevent unauthorized access to sensitive information.

---

### Error Handling

Error messages presented to users should never expose internal implementation details.

Logs intended for developers should avoid storing sensitive user information.

---

### Security Rules

- Never hardcode secrets.
- Never commit credentials.
- Follow the principle of least privilege.
- Validate external data before use.
- Protect user privacy by default.

---

## 12. Documentation Rules

Documentation is considered a first-class part of the MusicOS project.

Every architectural or behavioral change should be reflected in the documentation.

Documentation must evolve alongside the source code.

---

### Documentation Principles

Documentation should be:

- Accurate
- Clear
- Up-to-date
- Concise
- Easy to navigate

Documentation should explain why decisions were made, not only what was implemented.

---

### Required Documentation

The following documents should be maintained throughout the project:

- Vision
- PRD
- Information Architecture
- Design System
- Architecture
- Folder Structure
- Development Guide
- Tech Stack

Additional documentation may be introduced as the project evolves.

---

### Update Rules

Documentation should be updated whenever:

- Architecture changes.
- New Features are introduced.
- Public APIs change.
- Folder structures change.
- Development processes change.

---

### Writing Style

Documentation should:

- Use consistent terminology.
- Prefer simple language.
- Avoid unnecessary repetition.
- Use headings and lists for readability.

---

### Documentation Rules

- Documentation is part of every feature.
- Outdated documentation should be corrected promptly.
- Major decisions should be recorded before implementation.
- Documentation should remain version-controlled.

---

## 13. Definition of Done

A feature is considered complete only when it satisfies all required quality standards.

Completion is determined by objective criteria rather than subjective judgment.

---

### Functional Requirements

The feature:

- Meets all documented requirements.
- Behaves as expected.
- Handles success, loading, and error states correctly.
- Integrates correctly with the rest of the application.

---

### Architecture

The implementation:

- Follows the official architecture.
- Respects layer boundaries.
- Uses approved patterns.
- Does not introduce forbidden dependencies.

---

### Code Quality

The code:

- Is readable.
- Has a single responsibility.
- Avoids unnecessary complexity.
- Follows project coding standards.

---

### Testing

The feature:

- Includes appropriate automated tests.
- Passes all existing tests.
- Does not introduce regressions.

---

### Performance

The implementation:

- Maintains responsive UI.
- Avoids unnecessary rebuilds.
- Does not introduce measurable performance regressions.

---

### Documentation

Documentation has been updated when necessary.

Architectural or behavioral changes are reflected in the appropriate project documents.

---

### Review

The implementation has passed the project's code review checklist.

---

### Done Checklist

A feature is Done only when:

- Requirements are complete.
- Tests pass.
- Documentation is updated.
- Code review is complete.
- Performance is acceptable.
- No critical issues remain.

---

## 14. Release Strategy

MusicOS follows a structured release strategy to ensure every version is stable, well-tested, and fully documented before reaching users.

Releases should be predictable, repeatable, and traceable.

---

### Release Types

The project uses three primary release types:

- Major Release
- Minor Release
- Patch Release

Examples:

- v1.0.0
- v1.1.0
- v1.1.1

---

### Major Releases

Major releases introduce significant new functionality or architectural changes.

Examples:

- New Provider System
- Desktop Support
- Plugin Platform

---

### Minor Releases

Minor releases introduce new features while remaining backward compatible.

Examples:

- Smart Playlists
- Lyrics
- New Settings
- UI Improvements

---

### Patch Releases

Patch releases contain:

- Bug fixes
- Performance improvements
- Security fixes
- Stability improvements

Patch releases should never introduce breaking behavior.

---

### Pre-Release Validation

Before every release, verify:

- All automated tests pass.
- Performance targets are met.
- Documentation is up-to-date.
- Critical bugs are resolved.
- No known blockers remain.

---

### Versioning

MusicOS follows Semantic Versioning (SemVer):

MAJOR.MINOR.PATCH

Examples:

- 1.0.0
- 1.1.0
- 1.1.1

---

### Release Notes

Every release should include release notes summarizing:

- New Features
- Improvements
- Bug Fixes
- Known Issues (if any)
- Upgrade Notes (when applicable)

---

### Release Rules

- Never release unstable builds.
- Every release must be reproducible.
- Documentation must match the released version.
- Stable releases always originate from the `main` branch.













