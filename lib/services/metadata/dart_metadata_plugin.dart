import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/metadata.dart';

class DartTlmcDefaultMetadataPlugin {
  static MetadataPlugin create(Ref ref) {
    return MetadataPlugin.createDart(
      PluginConfiguration(
        type: PluginType.metadata,
        name: 'Dart TLMC Default',
        description: 'Default Dart-based TLMC metadata provider',
        version: '1.0.0',
        author: 'sqz269',
        entryPoint: '::dart::',
        pluginApiVersion: '1.0.0',
      ),
      ref,
    );
  }
}
