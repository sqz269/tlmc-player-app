import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/search_endpoint.dart';

/// TLMC implementation of MetadataSearchEndpointInterface
class TlmcSearchEndpoint implements MetadataSearchEndpointInterface {
  final Ref ref;

  TlmcSearchEndpoint(this.ref);

  @override
  List<String> get chips => ['all', 'tracks', 'albums', 'artists', 'playlists'];

  @override
  Future<SpotubeSearchResponseObject> all(String query) async {
    throw UnimplementedError('TLMC search all endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> albums(
    String query, {
    int? limit,
    int? offset,
  }) async {
    throw UnimplementedError('TLMC search albums endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>> artists(
    String query, {
    int? limit,
    int? offset,
  }) async {
    throw UnimplementedError(
        'TLMC search artists endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimplePlaylistObject>>
      playlists(
    String query, {
    int? limit,
    int? offset,
  }) async {
    throw UnimplementedError(
        'TLMC search playlists endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String query, {
    int? limit,
    int? offset,
  }) async {
    throw UnimplementedError('TLMC search tracks endpoint not implemented yet');
  }
}
