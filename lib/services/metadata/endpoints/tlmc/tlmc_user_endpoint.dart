import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/user_endpoint.dart';

/// TLMC implementation of MetadataUserEndpointInterface
class TlmcUserEndpoint implements MetadataUserEndpointInterface {
  final Ref ref;

  TlmcUserEndpoint(this.ref);

  @override
  Future<SpotubeUserObject> me() async {
    throw UnimplementedError('TLMC user me endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> savedTracks({
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC user saved tracks endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimplePlaylistObject>>
      savedPlaylists({
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC user saved playlists endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>>
      savedAlbums({
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC user saved albums endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>>
      savedArtists({
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC user saved artists endpoint not implemented yet');
  }

  @override
  Future<bool> isSavedPlaylist(String playlistId) async {
    throw UnimplementedError(
        'TLMC user is saved playlist endpoint not implemented yet');
  }

  @override
  Future<List<bool>> isSavedTracks(List<String> ids) async {
    throw UnimplementedError(
        'TLMC user is saved tracks endpoint not implemented yet');
  }

  @override
  Future<List<bool>> isSavedAlbums(List<String> ids) async {
    throw UnimplementedError(
        'TLMC user is saved albums endpoint not implemented yet');
  }

  @override
  Future<List<bool>> isSavedArtists(List<String> ids) async {
    throw UnimplementedError(
        'TLMC user is saved artists endpoint not implemented yet');
  }
}
