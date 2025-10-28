import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/track_endpoint.dart';

/// TLMC implementation of MetadataTrackEndpointInterface
class TlmcTrackEndpoint implements MetadataTrackEndpointInterface {
  @override
  Future<SpotubeFullTrackObject> getTrack(String id) async {
    throw UnimplementedError('TLMC track endpoint not implemented yet');
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
