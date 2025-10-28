import 'package:spotube/models/metadata/metadata.dart';
import 'auth_endpoint.dart';
import 'album_endpoint.dart';
import 'artist_endpoint.dart';
import 'browse_endpoint.dart';
import 'core_endpoint.dart';
import 'playlist_endpoint.dart';
import 'search_endpoint.dart';
import 'track_endpoint.dart';
import 'user_endpoint.dart';

/// Abstract base class for all metadata providers
/// This allows both Hetu-based and pure Dart implementations
abstract class MetadataProvider {
  /// Plugin configuration
  PluginConfiguration get config;

  /// Plugin API version
  String get apiVersion;

  /// Whether the provider is initialized
  bool get isInitialized;

  /// Initialize the provider
  Future<void> initialize();

  /// Dispose the provider
  Future<void> dispose();

  /// Get the auth endpoint
  MetadataAuthEndpointInterface get auth;

  /// Get the album endpoint
  MetadataAlbumEndpointInterface get album;

  /// Get the artist endpoint
  MetadataArtistEndpointInterface get artist;

  /// Get the browse endpoint
  MetadataBrowseEndpointInterface get browse;

  /// Get the search endpoint
  MetadataSearchEndpointInterface get search;

  /// Get the playlist endpoint
  MetadataPlaylistEndpointInterface get playlist;

  /// Get the track endpoint
  MetadataTrackEndpointInterface get track;

  /// Get the user endpoint
  MetadataUserEndpointInterface get user;

  /// Get the core endpoint
  MetadataCoreEndpointInterface get core;
}
