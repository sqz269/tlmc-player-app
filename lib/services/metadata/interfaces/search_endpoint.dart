import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for search endpoints
abstract class MetadataSearchEndpointInterface {
  /// Get search chips
  List<String> get chips;

  /// Search all content types
  Future<SpotubeSearchResponseObject> all(String query);

  /// Search albums
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> albums(
    String query, {
    int? limit,
    int? offset,
  });

  /// Search artists
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>> artists(
    String query, {
    int? limit,
    int? offset,
  });

  /// Search playlists
  Future<SpotubePaginationResponseObject<SpotubeSimplePlaylistObject>>
      playlists(
    String query, {
    int? limit,
    int? offset,
  });

  /// Search tracks
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String query, {
    int? limit,
    int? offset,
  });
}
