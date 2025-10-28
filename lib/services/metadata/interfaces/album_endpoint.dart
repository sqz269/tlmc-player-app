import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for album endpoints
abstract class MetadataAlbumEndpointInterface {
  /// Get a full album by ID
  Future<SpotubeFullAlbumObject> getAlbum(String id);

  /// Get tracks for an album
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String id, {
    int? offset,
    int? limit,
  });

  /// Get album releases
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> releases({
    int? offset,
    int? limit,
  });

  /// Save albums
  Future<void> save(List<String> ids);

  /// Unsave albums
  Future<void> unsave(List<String> ids);
}
