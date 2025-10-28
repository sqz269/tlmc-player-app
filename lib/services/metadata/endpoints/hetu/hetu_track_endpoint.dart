import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/track_endpoint.dart';

/// Hetu implementation of MetadataTrackEndpointInterface
class HetuTrackEndpoint implements MetadataTrackEndpointInterface {
  final Hetu _hetu;

  HetuTrackEndpoint(this._hetu);

  HTInstance get _hetuMetadataTrack =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("track")
          as HTInstance;

  @override
  Future<SpotubeFullTrackObject> getTrack(String id) async {
    final raw = await _hetuMetadataTrack
        .invoke("getTrack", positionalArgs: [id]) as Map;

    return SpotubeFullTrackObject.fromJson(
      raw.cast<String, dynamic>(),
    );
  }

  @override
  Future<void> save(List<String> ids) async {
    await _hetuMetadataTrack.invoke("save", positionalArgs: [ids]);
  }

  @override
  Future<void> unsave(List<String> ids) async {
    await _hetuMetadataTrack.invoke("unsave", positionalArgs: [ids]);
  }

  @override
  Future<List<SpotubeFullTrackObject>> radio(String id) async {
    final result = await _hetuMetadataTrack.invoke(
      "radio",
      positionalArgs: [id],
    );

    return (result as List)
        .map(
          (e) => SpotubeFullTrackObject.fromJson(
            (e as Map).cast<String, dynamic>(),
          ),
        )
        .toList();
  }
}
