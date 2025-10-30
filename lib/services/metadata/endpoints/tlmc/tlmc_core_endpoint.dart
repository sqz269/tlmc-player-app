import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/core_endpoint.dart';

/// TLMC implementation of MetadataCoreEndpointInterface
class TlmcCoreEndpoint implements MetadataCoreEndpointInterface {
  final Ref ref;

  TlmcCoreEndpoint(this.ref);

  @override
  Future<PluginUpdateAvailable?> checkUpdate(
      PluginConfiguration pluginConfig) async {
    // Implement TLMC-specific update checking logic here
    // This could involve checking package versions, GitHub releases, etc.
    return null; // No updates available by default
  }

  @override
  Future<String> get support async {
    // Return support information for TLMC providers
    return "TLMC Metadata Provider v1.0.0";
  }

  @override
  Future<void> scrobble(Map<String, dynamic> details) async {
    // Implement TLMC-specific scrobbling logic here
    // This could involve sending data to Last.fm, ListenBrainz, etc.
    throw UnimplementedError('TLMC scrobble endpoint not implemented yet');
  }
}
