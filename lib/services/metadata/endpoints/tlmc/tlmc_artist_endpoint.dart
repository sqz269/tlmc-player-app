import 'package:backend_client_api/api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/provider/user_preferences/user_preferences_provider.dart';
import 'package:spotube/services/logger/logger.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/mapping_utils.dart';
import 'package:spotube/services/metadata/interfaces/artist_endpoint.dart';

/// TLMC implementation of MetadataArtistEndpointInterface
class TlmcArtistEndpoint implements MetadataArtistEndpointInterface {
  final Ref ref;

  TlmcArtistEndpoint(this.ref);

  @override
  Future<SpotubeFullArtistObject> getArtist(String id) async {
    AppLogger.log.i('Getting artist $id');

    final tlmcInstance = ref.read(userPreferencesProvider).tlmcInstance;
    var client = ApiClient(basePath: tlmcInstance);
    var circleApi = CircleApi(client);
    var response = await circleApi.getCircleByName(id);
    if (response == null) {
      throw Exception('Artist not found');
    }
    return SpotubeFullArtistObject(
      id: response.id!,
      name: response.name!,
      externalUri: "",
      images: [],
    );
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
    var offsetInt = offset ?? 0;
    var limitInt = limit ?? 20;

    AppLogger.log.i('Getting artist $id albums');
    final tlmcInstance = ref.read(userPreferencesProvider).tlmcInstance;
    var client = ApiClient(basePath: tlmcInstance);
    var circleApi = CircleApi(client);

    var response = await circleApi.getCircleAlbumsByName(id,
        start: offsetInt, limit: limitInt);
    if (response == null) {
      throw Exception('Artist not found');
    }

    return SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>(
      limit: response.count ?? 0,
      nextOffset: (response.count ?? 0) + (limitInt ?? 20),
      total: response.total ?? 0,
      hasMore: true,
      items: response.albums
              ?.map((album) =>
                  TlmcToSpotubeMappingUtils.toSpotubeSimpleAlbumObject(album))
              .toList() ??
          [],
    );
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
