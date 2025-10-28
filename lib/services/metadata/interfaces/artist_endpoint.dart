import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for artist endpoints
abstract class MetadataArtistEndpointInterface {
  /// Get a full artist by ID
  Future<SpotubeFullArtistObject> getArtist(String id);

  /// Get artist's top tracks
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> topTracks(
    String id, {
    int? offset,
    int? limit,
  });

  /// Get artist's albums
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> albums(
    String id, {
    int? offset,
    int? limit,
  });

  /// Save artists
  Future<void> save(List<String> ids);

  /// Unsave artists
  Future<void> unsave(List<String> ids);

  /// Get related artists
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>> related(
    String id, {
    int? offset,
    int? limit,
  });
}
