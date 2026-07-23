import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// The application's single Drift database instance.
///
/// ### Schema
///
/// The tables list is intentionally empty at this stage.
/// Tables are introduced incrementally in future sprints as each
/// feature's data layer is implemented. Drift compiles cleanly
/// with an empty schema — no placeholder table is required or used.
///
/// ### Background isolate
///
/// [AppDatabase.connect] uses [driftDatabase] from `drift_flutter`,
/// which opens the database on a background isolate automatically,
/// satisfying the tech stack requirement:
/// _"All heavy database operations must run on a background isolate."_
///
/// ### WAL mode
///
/// WAL journal mode will be enabled via [MigrationStrategy.beforeOpen]
/// once the first schema migration is introduced. Enabling it on an
/// empty schema provides no benefit.
///
/// ### Lifecycle
///
/// [AppDatabase] is a long-lived singleton registered in GetIt.
/// Closing it on application termination is handled by the
/// AppLifecycleObserver, which is implemented in a later sprint.
@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  /// Creates an [AppDatabase] connected to a background isolate.
  ///
  /// This is the only constructor used in production.
  /// Pass a custom [QueryExecutor] in tests to inject an in-memory database.
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  /// Opens a persistent SQLite database on a background isolate.
  ///
  /// The database file is named `musicos.db` and is placed in the
  /// application's default documents directory via [driftDatabase].
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'musicos');
  }
}
