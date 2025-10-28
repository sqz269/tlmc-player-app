import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/artist_endpoint.dart';

/// Hetu implementation of MetadataArtistEndpointInterface
class HetuArtistEndpoint implements MetadataArtistEndpointInterface {
  final Hetu _hetu;

  HetuArtistEndpoint(this._hetu);

  HTInstance get _hetuMetadataArtist =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("artist")
          as HTInstance;

  @override
  Future<SpotubeFullArtistObject> getArtist(String id) async {
    final raw = await _hetuMetadataArtist
        .invoke("getArtist", positionalArgs: [id]) as Map;

    return SpotubeFullArtistObject.fromJson(
      raw.cast<String, dynamic>(),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> topTracks(
    String id, {
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataArtist.invoke(
      "topTracks",
      positionalArgs: [id],
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeFullTrackObject>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) => SpotubeFullTrackObject.fromJson(
        json.cast<String, dynamic>(),
      ),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> albums(
    String id, {
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataArtist.invoke(
      "albums",
      positionalArgs: [id],
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) => SpotubeSimpleAlbumObject.fromJson(
        json.cast<String, dynamic>(),
      ),
    );
  }

  @override
  Future<void> save(List<String> ids) async {
    await _hetuMetadataArtist.invoke(
      "save",
      positionalArgs: [ids],
    );
  }

  @override
  Future<void> unsave(List<String> ids) async {
    await _hetuMetadataArtist.invoke(
      "unsave",
      positionalArgs: [ids],
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>> related(
    String id, {
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataArtist.invoke(
      "related",
      positionalArgs: [id],
      namedArgs: {
        "offset": offset,
        "limit": limit ?? 20,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeFullArtistObject>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) => SpotubeFullArtistObject.fromJson(
        json.cast<String, dynamic>(),
      ),
    );
  }
}
