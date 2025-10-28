import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/playlist_endpoint.dart';

/// TLMC implementation of MetadataPlaylistEndpointInterface
class TlmcPlaylistEndpoint implements MetadataPlaylistEndpointInterface {
  @override
  Future<SpotubeFullPlaylistObject> getPlaylist(String id) async {
    throw UnimplementedError('TLMC playlist endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String id, {
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC playlist tracks endpoint not implemented yet');
  }

  @override
  Future<SpotubeFullPlaylistObject?> create(
    String userId, {
    required String name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    throw UnimplementedError(
        'TLMC playlist create endpoint not implemented yet');
  }

  @override
  Future<void> update(
    String playlistId, {
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    throw UnimplementedError(
        'TLMC playlist update endpoint not implemented yet');
  }

  @override
  Future<void> addTracks(
    String playlistId, {
    required List<String> trackIds,
    int? position,
  }) async {
    throw UnimplementedError(
        'TLMC playlist add tracks endpoint not implemented yet');
  }

  @override
  Future<void> removeTracks(
    String playlistId, {
    required List<String> trackIds,
  }) async {
    throw UnimplementedError(
        'TLMC playlist remove tracks endpoint not implemented yet');
  }

  @override
  Future<void> save(String playlistId) async {
    throw UnimplementedError('TLMC playlist save endpoint not implemented yet');
  }

  @override
  Future<void> unsave(String playlistId) async {
    throw UnimplementedError(
        'TLMC playlist unsave endpoint not implemented yet');
  }

  @override
  Future<void> deletePlaylist(String playlistId) async {
    throw UnimplementedError(
        'TLMC playlist delete endpoint not implemented yet');
  }
}
