import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/index.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_auth_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_album_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_artist_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_browse_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_core_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_playlist_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_search_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_track_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/tlmc_user_endpoint.dart';

/// Dart-based implementation of MetadataProvider
/// This allows pure Dart code to become metadata providers
class DartMetadataProvider implements MetadataProvider {
  final PluginConfiguration _config;

  late final MetadataAuthEndpointInterface _auth;
  late final MetadataAlbumEndpointInterface _album;
  late final MetadataArtistEndpointInterface _artist;
  late final MetadataBrowseEndpointInterface _browse;
  late final MetadataSearchEndpointInterface _search;
  late final MetadataPlaylistEndpointInterface _playlist;
  late final MetadataTrackEndpointInterface _track;
  late final MetadataUserEndpointInterface _user;
  late final MetadataCoreEndpointInterface _core;

  bool _isInitialized = false;

  DartMetadataProvider._(this._config) {
    _auth = TlmcAuthEndpoint();
    _album = TlmcAlbumEndpoint();
    _artist = TlmcArtistEndpoint();
    _browse = TlmcBrowseEndpoint();
    _search = TlmcSearchEndpoint();
    _playlist = TlmcPlaylistEndpoint();
    _track = TlmcTrackEndpoint();
    _user = TlmcUserEndpoint();
    _core = TlmcCoreEndpoint();
  }

  @override
  PluginConfiguration get config => _config;

  @override
  String get apiVersion => "1.0.0";

  @override
  bool get isInitialized => _isInitialized;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize any Dart-specific resources here
    // This could include setting up HTTP clients, databases, etc.

    _isInitialized = true;
  }

  @override
  Future<void> dispose() async {
    _isInitialized = false;
    // Cleanup any Dart-specific resources here
  }

  @override
  MetadataAuthEndpointInterface get auth => _auth;

  @override
  MetadataAlbumEndpointInterface get album => _album;

  @override
  MetadataArtistEndpointInterface get artist => _artist;

  @override
  MetadataBrowseEndpointInterface get browse => _browse;

  @override
  MetadataSearchEndpointInterface get search => _search;

  @override
  MetadataPlaylistEndpointInterface get playlist => _playlist;

  @override
  MetadataTrackEndpointInterface get track => _track;

  @override
  MetadataUserEndpointInterface get user => _user;

  @override
  MetadataCoreEndpointInterface get core => _core;

  /// Factory method to create a DartMetadataProvider
  static DartMetadataProvider create(PluginConfiguration config) {
    return DartMetadataProvider._(config);
  }
}
