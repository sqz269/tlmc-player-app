import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/album_endpoint.dart';

/// Hetu implementation of MetadataAlbumEndpointInterface
class HetuAlbumEndpoint implements MetadataAlbumEndpointInterface {
  final Hetu _hetu;

  HetuAlbumEndpoint(this._hetu);

  HTInstance get _hetuMetadataAlbum =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("album")
          as HTInstance;

  @override
  Future<SpotubeFullAlbumObject> getAlbum(String id) async {
    final raw = await _hetuMetadataAlbum
        .invoke("getAlbum", positionalArgs: [id]) as Map;

    return SpotubeFullAlbumObject.fromJson(
      raw.cast<String, dynamic>(),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String id, {
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataAlbum.invoke(
      "tracks",
      positionalArgs: [id],
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeFullTrackObject>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) =>
          SpotubeFullTrackObject.fromJson(json.cast<String, dynamic>()),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> releases({
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataAlbum.invoke(
      "releases",
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) =>
          SpotubeSimpleAlbumObject.fromJson(json.cast<String, dynamic>()),
    );
  }

  @override
  Future<void> save(List<String> ids) async {
    await _hetuMetadataAlbum.invoke(
      "save",
      positionalArgs: [ids],
    );
  }

  @override
  Future<void> unsave(List<String> ids) async {
    await _hetuMetadataAlbum.invoke(
      "unsave",
      positionalArgs: [ids],
    );
  }
}
