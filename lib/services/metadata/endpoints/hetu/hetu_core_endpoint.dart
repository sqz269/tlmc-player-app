import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/core_endpoint.dart';

/// Hetu implementation of MetadataCoreEndpointInterface
class HetuCoreEndpoint implements MetadataCoreEndpointInterface {
  final Hetu _hetu;

  HetuCoreEndpoint(this._hetu);

  HTInstance get _hetuMetadataPluginUpdater =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("core")
          as HTInstance;

  @override
  Future<PluginUpdateAvailable?> checkUpdate(
    PluginConfiguration pluginConfig,
  ) async {
    final result = await _hetuMetadataPluginUpdater.invoke(
      "checkUpdate",
      positionalArgs: [pluginConfig.toJson()],
    );

    return result == null
        ? null
        : PluginUpdateAvailable.fromJson(
            (result as Map).cast<String, dynamic>(),
          );
  }

  @override
  Future<String> get support async {
    final result = await _hetuMetadataPluginUpdater.memberGet("support");

    return result as String;
  }

  @override
  Future<void> scrobble(Map<String, dynamic> details) {
    return _hetuMetadataPluginUpdater.invoke(
      "scrobble",
      positionalArgs: [details],
    );
  }
}
