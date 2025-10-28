import 'package:backend_client_api/api.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/mapping_utils.dart';
import 'package:spotube/services/metadata/interfaces/browse_endpoint.dart';

/// TLMC implementation of MetadataBrowseEndpointInterface
class TlmcBrowseEndpoint implements MetadataBrowseEndpointInterface {
  @override
  Future<SpotubePaginationResponseObject<SpotubeBrowseSectionObject<Object>>>
      sections({
    int? offset,
    int? limit,
  }) async {
    var offsetInt = offset ?? 0;
    var limitInt = limit ?? 20;

    var client = ApiClient(basePath: 'https://staging-api.marisad.me');
    var albumApi = AlbumApi(client);
    var response = await albumApi.getAlbums(
      start: offsetInt,
      limit: limitInt,
      sortOrder: SortOrder.descending,
      sort: AlbumOrderOptions.date,
    );

    if (response == null) {
      return SpotubePaginationResponseObject<
          SpotubeBrowseSectionObject<Object>>(
        limit: 0,
        nextOffset: 0,
        total: 0,
        hasMore: false,
        items: [],
      );
    }

    return SpotubePaginationResponseObject<SpotubeBrowseSectionObject<Object>>(
      limit: limitInt,
      nextOffset: response.count ?? 0 + limitInt,
      total: response.total ?? 0,
      hasMore: true,
      items: [
        TlmcToSpotubeMappingUtils.toSpotubeBrowseSectionObject(response.albums!)
      ],
    );
  }

  @override
  Future<SpotubePaginationResponseObject<Object>> sectionItems(
    String id, {
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC browse section items endpoint not implemented yet');
  }
}
