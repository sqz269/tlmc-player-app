import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/browse_endpoint.dart';

/// Hetu implementation of MetadataBrowseEndpointInterface
class HetuBrowseEndpoint implements MetadataBrowseEndpointInterface {
  final Hetu _hetu;

  HetuBrowseEndpoint(this._hetu);

  HTInstance get _hetuMetadataBrowse =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("browse")
          as HTInstance;

  @override
  Future<SpotubePaginationResponseObject<SpotubeBrowseSectionObject<Object>>>
      sections({
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataBrowse.invoke(
      "sections",
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<
        SpotubeBrowseSectionObject<Object>>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) => SpotubeBrowseSectionObject<Object>.fromJson(
        json.cast<String, dynamic>(),
        (json) {
          final isPlaylist = json["owner"] != null;
          final isAlbum = json["artists"] != null;
          if (isPlaylist) {
            return SpotubeSimplePlaylistObject.fromJson(
              json.cast<String, dynamic>(),
            );
          } else if (isAlbum) {
            return SpotubeSimpleAlbumObject.fromJson(
              json.cast<String, dynamic>(),
            );
          } else {
            return SpotubeFullArtistObject.fromJson(
              json.cast<String, dynamic>(),
            );
          }
        },
      ),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<Object>> sectionItems(
    String id, {
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataBrowse.invoke(
      "sectionItems",
      positionalArgs: [id],
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<Object>.fromJson(
      raw.cast<String, dynamic>(),
      (json) {
        final isPlaylist = json["owner"] != null;
        final isAlbum = json["artists"] != null;
        if (isPlaylist) {
          return SpotubeSimplePlaylistObject.fromJson(
            json.cast<String, dynamic>(),
          );
        } else if (isAlbum) {
          return SpotubeSimpleAlbumObject.fromJson(
            json.cast<String, dynamic>(),
          );
        } else {
          return SpotubeFullArtistObject.fromJson(
            json.cast<String, dynamic>(),
          );
        }
      },
    );
  }
}
