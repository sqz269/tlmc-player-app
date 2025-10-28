import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for user endpoints
abstract class MetadataUserEndpointInterface {
  /// Get current user profile
  Future<SpotubeUserObject> me();

  /// Get user's saved tracks
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> savedTracks({
    int? offset,
    int? limit,
  });

  /// Get user's saved playlists
  Future<SpotubePaginationResponseObject<SpotubeSimplePlaylistObject>>
      savedPlaylists({
    int? offset,
    int? limit,
  });

  /// Get user's saved albums
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>>
      savedAlbums({
    int? offset,
    int? limit,
  });

  /// Get user's saved artists
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>>
      savedArtists({
    int? offset,
    int? limit,
  });

  /// Check if playlist is saved
  Future<bool> isSavedPlaylist(String playlistId);

  /// Check if tracks are saved
  Future<List<bool>> isSavedTracks(List<String> ids);

  /// Check if albums are saved
  Future<List<bool>> isSavedAlbums(List<String> ids);

  /// Check if artists are saved
  Future<List<bool>> isSavedArtists(List<String> ids);
}
