import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/playlist_endpoint.dart';

/// Hetu implementation of MetadataPlaylistEndpointInterface
class HetuPlaylistEndpoint implements MetadataPlaylistEndpointInterface {
  final Hetu _hetu;

  HetuPlaylistEndpoint(this._hetu);

  HTInstance get _hetuMetadataPlaylist =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("playlist")
          as HTInstance;

  @override
  Future<SpotubeFullPlaylistObject> getPlaylist(String id) async {
    final raw = await _hetuMetadataPlaylist
        .invoke("getPlaylist", positionalArgs: [id]) as Map;

    return SpotubeFullPlaylistObject.fromJson(
      raw.cast<String, dynamic>(),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String id, {
    int? offset,
    int? limit,
  }) async {
    final raw = await _hetuMetadataPlaylist.invoke(
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
  Future<SpotubeFullPlaylistObject?> create(
    String userId, {
    required String name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    final raw = await _hetuMetadataPlaylist.invoke(
      "create",
      positionalArgs: [userId],
      namedArgs: {
        "name": name,
        "description": description,
        "public": public,
        "collaborative": collaborative,
      }..removeWhere((key, value) => value == null),
    ) as Map?;

    if (raw == null) return null;

    return SpotubeFullPlaylistObject.fromJson(
      raw.cast<String, dynamic>(),
    );
  }

  @override
  Future<void> update(
    String playlistId, {
    String? name,
    String? description,
    bool? public,
    bool? collaborative,
  }) async {
    await _hetuMetadataPlaylist.invoke(
      "update",
      positionalArgs: [playlistId],
      namedArgs: {
        "name": name,
        "description": description,
        "public": public,
        "collaborative": collaborative,
      }..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<void> addTracks(
    String playlistId, {
    required List<String> trackIds,
    int? position,
  }) async {
    await _hetuMetadataPlaylist.invoke(
      "addTracks",
      positionalArgs: [playlistId],
      namedArgs: {
        "trackIds": trackIds,
        "position": position,
      }..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<void> removeTracks(
    String playlistId, {
    required List<String> trackIds,
  }) async {
    await _hetuMetadataPlaylist.invoke(
      "removeTracks",
      positionalArgs: [playlistId],
      namedArgs: {
        "trackIds": trackIds,
      }..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<void> save(String playlistId) async {
    await _hetuMetadataPlaylist.invoke(
      "save",
      positionalArgs: [playlistId],
    );
  }

  @override
  Future<void> unsave(String playlistId) async {
    await _hetuMetadataPlaylist.invoke(
      "unsave",
      positionalArgs: [playlistId],
    );
  }

  @override
  Future<void> deletePlaylist(String playlistId) async {
    return await _hetuMetadataPlaylist.invoke(
      "deletePlaylist",
      positionalArgs: [playlistId],
    );
  }
}
