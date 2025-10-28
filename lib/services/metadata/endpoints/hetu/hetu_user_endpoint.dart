import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/user_endpoint.dart';

/// Hetu implementation of MetadataUserEndpointInterface
class HetuUserEndpoint implements MetadataUserEndpointInterface {
  final Hetu _hetu;

  HetuUserEndpoint(this._hetu);

  HTInstance get _hetuMetadataUser =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("user")
          as HTInstance;

  @override
  Future<SpotubeUserObject> me() async {
    final raw = await _hetuMetadataUser.invoke("me") as Map;

    return SpotubeUserObject.fromJson(
      raw.cast<String, dynamic>(),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> savedTracks({
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataUser.invoke(
      "savedTracks",
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
  Future<SpotubePaginationResponseObject<SpotubeSimplePlaylistObject>>
      savedPlaylists({
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataUser.invoke(
      "savedPlaylists",
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<
        SpotubeSimplePlaylistObject>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) =>
          SpotubeSimplePlaylistObject.fromJson(json.cast<String, dynamic>()),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>>
      savedAlbums({
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataUser.invoke(
      "savedAlbums",
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
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>>
      savedArtists({
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataUser.invoke(
      "savedArtists",
      namedArgs: {
        "offset": offset,
        "limit": limit,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeFullArtistObject>.fromJson(
      raw.cast<String, dynamic>(),
      (Map json) =>
          SpotubeFullArtistObject.fromJson(json.cast<String, dynamic>()),
    );
  }

  @override
  Future<bool> isSavedPlaylist(String playlistId) async {
    return await _hetuMetadataUser.invoke(
      "isSavedPlaylist",
      positionalArgs: [playlistId],
    ) as bool;
  }

  @override
  Future<List<bool>> isSavedTracks(List<String> ids) async {
    final values = await _hetuMetadataUser.invoke(
      "isSavedTracks",
      positionalArgs: [ids],
    );
    return (values as List).cast<bool>();
  }

  @override
  Future<List<bool>> isSavedAlbums(List<String> ids) async {
    final values = await _hetuMetadataUser.invoke(
      "isSavedAlbums",
      positionalArgs: [ids],
    ) as List;
    return values.cast<bool>();
  }

  @override
  Future<List<bool>> isSavedArtists(List<String> ids) async {
    final values = await _hetuMetadataUser.invoke(
      "isSavedArtists",
      positionalArgs: [ids],
    ) as List;

    return values.cast<bool>();
  }
}
