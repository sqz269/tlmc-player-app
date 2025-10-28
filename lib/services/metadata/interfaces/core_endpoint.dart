import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for core endpoints
abstract class MetadataCoreEndpointInterface {
  /// Check for plugin updates
  Future<PluginUpdateAvailable?> checkUpdate(PluginConfiguration pluginConfig);

  /// Get support information
  Future<String> get support;

  /// Scrobble a track
  Future<void> scrobble(Map<String, dynamic> details);
}
