import 'package:backend_client_api/api.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/mapping_utils.dart';
import 'package:spotube/services/metadata/interfaces/track_endpoint.dart';

/// TLMC implementation of MetadataTrackEndpointInterface
class TlmcTrackEndpoint implements MetadataTrackEndpointInterface {
  @override
  Future<SpotubeFullTrackObject> getTrack(String id) async {
    var client = ApiClient(basePath: 'https://staging-api.marisad.me');
    var trackApi = TrackApi(client);
    var response = await trackApi.getTrack(id);

    if (response == null) {
      throw Exception('Track not found');
    }

    return TlmcToSpotubeMappingUtils.toSpotubeFullTrackObject(
        response, response.album!);
  }

  @override
  Future<void> save(List<String> ids) async {
    throw UnimplementedError('TLMC track save endpoint not implemented yet');
  }

  @override
  Future<void> unsave(List<String> ids) async {
    throw UnimplementedError('TLMC track unsave endpoint not implemented yet');
  }

  @override
  Future<List<SpotubeFullTrackObject>> radio(String id) async {
    throw UnimplementedError('TLMC track radio endpoint not implemented yet');
  }
}
