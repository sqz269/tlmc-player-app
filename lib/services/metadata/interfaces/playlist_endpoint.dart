import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for playlist endpoints
abstract class MetadataPlaylistEndpointInterface {
  /// Get a full playlist by ID
  Future<SpotubeFullPlaylistObject> getPlaylist(String id);

  /// Get playlist tracks
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String id, {
    int? offset,
    int? limit,
  });

  /// Create a playlist
  Future<SpotubeFullPlaylistObject?> create(
    String userId, {
    required String name,
    String? description,
    bool? public,
    bool? collaborative,
  });

  /// Update a playlist
  Future<void> update(
    String playlistId, {
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  });

  /// Add tracks to playlist
  Future<void> addTracks(
    String playlistId, {
    required List<String> trackIds,
    int? position,
  });

  /// Remove tracks from playlist
  Future<void> removeTracks(
    String playlistId, {
    required List<String> trackIds,
  });

  /// Save a playlist
  Future<void> save(String playlistId);

  /// Unsave a playlist
  Future<void> unsave(String playlistId);

  /// Delete a playlist
  Future<void> deletePlaylist(String playlistId);
}
