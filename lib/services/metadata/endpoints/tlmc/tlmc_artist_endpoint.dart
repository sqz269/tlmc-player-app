import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/artist_endpoint.dart';

/// TLMC implementation of MetadataArtistEndpointInterface
class TlmcArtistEndpoint implements MetadataArtistEndpointInterface {
  final Ref ref;

  TlmcArtistEndpoint(this.ref);

  @override
  Future<SpotubeFullArtistObject> getArtist(String id) async {
    throw UnimplementedError('TLMC artist endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> topTracks(
    String id, {
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC artist top tracks endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> albums(
    String id, {
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError('TLMC artist albums endpoint not implemented yet');
  }

  @override
  Future<void> save(List<String> ids) async {
    throw UnimplementedError('TLMC artist save endpoint not implemented yet');
  }

  @override
  Future<void> unsave(List<String> ids) async {
    throw UnimplementedError('TLMC artist unsave endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>> related(
    String id, {
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC artist related endpoint not implemented yet');
  }
}
