import 'dart:typed_data';

import 'package:pub_semver/pub_semver.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/index.dart';
import 'package:spotube/services/metadata/providers/hetu_metadata_provider.dart';
import 'package:spotube/services/metadata/providers/dart_metadata_provider.dart';

const defaultMetadataLimit = "20";

/// Main metadata plugin class that can work with both Hetu and Dart providers
class MetadataPlugin {
  static final pluginApiVersion = Version.parse("1.0.0");

  final MetadataProvider _provider;

  MetadataPlugin._(this._provider);

  /// Create a Hetu-based metadata plugin
  static Future<MetadataPlugin> createHetu(
    PluginConfiguration config,
    Uint8List byteCode,
  ) async {
    final provider = await HetuMetadataProvider.create(config, byteCode);
    await provider.initialize();
    return MetadataPlugin._(provider);
  }

  /// Create a Dart-based metadata plugin
  static MetadataPlugin createDart(PluginConfiguration config) {
    final provider = DartMetadataProvider.create(config);
    return MetadataPlugin._(provider);
  }

  /// Legacy method for backward compatibility - creates Hetu provider
  static Future<MetadataPlugin> create(
    PluginConfiguration config,
    Uint8List byteCode,
  ) async {
    return createHetu(config, byteCode);
  }

  /// Get the underlying provider
  MetadataProvider get provider => _provider;

  /// Get the plugin configuration
  PluginConfiguration get config => _provider.config;

  /// Get the API version
  String get apiVersion => _provider.apiVersion;

  /// Check if the plugin is initialized
  bool get isInitialized => _provider.isInitialized;

  /// Initialize the plugin
  Future<void> initialize() async {
    await _provider.initialize();
  }

  /// Dispose the plugin
  Future<void> dispose() async {
    await _provider.dispose();
  }

  // Delegate all endpoint access to the provider
  MetadataAuthEndpointInterface get auth => _provider.auth;
  MetadataAlbumEndpointInterface get album => _provider.album;
  MetadataArtistEndpointInterface get artist => _provider.artist;
  MetadataBrowseEndpointInterface get browse => _provider.browse;
  MetadataSearchEndpointInterface get search => _provider.search;
  MetadataPlaylistEndpointInterface get playlist => _provider.playlist;
  MetadataTrackEndpointInterface get track => _provider.track;
  MetadataUserEndpointInterface get user => _provider.user;
  MetadataCoreEndpointInterface get core => _provider.core;
}
