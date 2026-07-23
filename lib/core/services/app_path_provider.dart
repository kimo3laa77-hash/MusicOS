import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Resolves and holds the platform-specific directory paths used by MusicOS.
///
/// Obtain the singleton from the GetIt service locator:
/// ```dart
/// final paths = getIt<AppPathProvider>();
/// final dir = paths.documentsDir;
/// ```
///
/// All directories are resolved once during [bootstrap] via [AppPathProvider.init]
/// and are then available synchronously for the lifetime of the application.
///
/// New directories should be added here only when a concrete consumer requires
/// them — never speculatively.
class AppPathProvider {
  /// The application's permanent documents directory.
  ///
  /// Suitable for data that must persist across application restarts and
  /// survive updates, such as exported playlists or user-generated content.
  ///
  /// Resolved via [getApplicationDocumentsDirectory].
  final Directory documentsDir;

  AppPathProvider._({required this.documentsDir});

  /// Resolves platform directories and returns a fully initialised instance.
  ///
  /// Called once inside [configureDependencies] before the widget tree is built.
  static Future<AppPathProvider> init() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    return AppPathProvider._(documentsDir: documentsDir);
  }
}
