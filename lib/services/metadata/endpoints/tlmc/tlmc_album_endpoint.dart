import 'package:backend_client_api/api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/provider/user_preferences/user_preferences_provider.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/mapping_utils.dart';
import 'package:spotube/services/metadata/interfaces/album_endpoint.dart';

/// Dart implementation of MetadataAlbumEndpointInterface
/// This is a placeholder implementation that can be extended
class TlmcAlbumEndpoint implements MetadataAlbumEndpointInterface {
  final Ref ref;

  TlmcAlbumEndpoint(this.ref);

  @override
  Future<SpotubeFullAlbumObject> getAlbum(String id) async {
    // Implement Dart-specific album retrieval logic here
    // This could involve HTTP requests to music APIs, database queries, etc.
    throw UnimplementedError('Dart album endpoint not implemented yet');
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String id, {
    int? offset,
    int? limit,
  }) async {
    // Implement Dart-specific track retrieval logic here
    final tlmcInstance = ref.read(userPreferencesProvider).tlmcInstance;
    var client = ApiClient(basePath: tlmcInstance);
    var albumApi = AlbumApi(client);
    var response = await albumApi.getAlbum(id);

    if (response == null) {
      return SpotubePaginationResponseObject<SpotubeFullTrackObject>(
        limit: 0,
        nextOffset: 0,
        total: 0,
        hasMore: false,
        items: [],
      );
    }

    return SpotubePaginationResponseObject<SpotubeFullTrackObject>(
      limit: response.tracks!.length,
      nextOffset: null,
      total: response.tracks!.length,
      hasMore: false,
      items: response.tracks!
          .map((track) => TlmcToSpotubeMappingUtils.toSpotubeFullTrackObject(
              track, response))
          .toList(),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> releases({
    int? offset,
    int? limit,
  }) async {
    // Implement Dart-specific releases logic here
    final tlmcInstance = ref.read(userPreferencesProvider).tlmcInstance;
    var client = ApiClient(basePath: tlmcInstance);
    var albumApi = AlbumApi(client);
    var response = await albumApi.getAlbums(
      start: offset ?? 0,
      limit: limit ?? 20,
      sortOrder: SortOrder.descending,
      sort: AlbumOrderOptions.date,
    );
    return SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>(
      limit: response?.albums?.length ?? 0,
      nextOffset: (response?.count ?? 0) + (limit ?? 20),
      total: response?.total ?? 0,
      hasMore: true,
      items: response?.albums
              ?.map((album) =>
                  TlmcToSpotubeMappingUtils.toSpotubeSimpleAlbumObject(album))
              .toList() ??
          [],
    );
  }

  @override
  Future<void> save(List<String> ids) async {
    // Implement Dart-specific save logic here
    throw UnimplementedError('Dart album save endpoint not implemented yet');
  }

  @override
  Future<void> unsave(List<String> ids) async {
    // Implement Dart-specific unsave logic here
    throw UnimplementedError('Dart album unsave endpoint not implemented yet');
  }
}
