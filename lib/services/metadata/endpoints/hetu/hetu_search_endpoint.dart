import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/search_endpoint.dart';

/// Hetu implementation of MetadataSearchEndpointInterface
class HetuSearchEndpoint implements MetadataSearchEndpointInterface {
  final Hetu _hetu;

  HetuSearchEndpoint(this._hetu);

  HTInstance get _hetuMetadataSearch =>
      (_hetu.fetch("metadataPlugin") as HTInstance).memberGet("search")
          as HTInstance;

  @override
  List<String> get chips {
    return (_hetuMetadataSearch.memberGet("chips") as List).cast<String>();
  }

  @override
  Future<SpotubeSearchResponseObject> all(String query) async {
    if (query.isEmpty) {
      return SpotubeSearchResponseObject(
        albums: [],
        artists: [],
        playlists: [],
        tracks: [],
      );
    }

    final raw = await _hetuMetadataSearch.invoke(
      "all",
      positionalArgs: [query],
    ) as Map;

    return SpotubeSearchResponseObject.fromJson(raw.cast<String, dynamic>());
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>> albums(
    String query, {
    int? limit,
    int? offset,
  }) async {
    if (query.isEmpty) {
      return SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>(
        items: [],
        total: 0,
        limit: limit ?? 20,
        hasMore: false,
        nextOffset: null,
      );
    }

    final raw = await _hetuMetadataSearch.invoke(
      "albums",
      positionalArgs: [query],
      namedArgs: {
        "limit": limit,
        "offset": offset,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeSimpleAlbumObject>.fromJson(
      raw.cast<String, dynamic>(),
      (json) => SpotubeSimpleAlbumObject.fromJson(json.cast<String, dynamic>()),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullArtistObject>> artists(
    String query, {
    int? limit,
    int? offset,
  }) async {
    if (query.isEmpty) {
      return SpotubePaginationResponseObject<SpotubeFullArtistObject>(
        items: [],
        total: 0,
        limit: limit ?? 20,
        hasMore: false,
        nextOffset: null,
      );
    }

    final raw = await _hetuMetadataSearch.invoke(
      "artists",
      positionalArgs: [query],
      namedArgs: {
        "limit": limit,
        "offset": offset,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeFullArtistObject>.fromJson(
      raw.cast<String, dynamic>(),
      (json) => SpotubeFullArtistObject.fromJson(
        json.cast<String, dynamic>(),
      ),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeSimplePlaylistObject>>
      playlists(
    String query, {
    int? limit,
    int? offset,
  }) async {
    if (query.isEmpty) {
      return SpotubePaginationResponseObject<SpotubeSimplePlaylistObject>(
        items: [],
        total: 0,
        limit: limit ?? 20,
        hasMore: false,
        nextOffset: null,
      );
    }

    final raw = await _hetuMetadataSearch.invoke(
      "playlists",
      positionalArgs: [query],
      namedArgs: {
        "limit": limit,
        "offset": offset,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<
        SpotubeSimplePlaylistObject>.fromJson(
      raw.cast<String, dynamic>(),
      (json) => SpotubeSimplePlaylistObject.fromJson(
        json.cast<String, dynamic>(),
      ),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeFullTrackObject>> tracks(
    String query, {
    int? limit,
    int? offset,
  }) async {
    if (query.isEmpty) {
      return SpotubePaginationResponseObject<SpotubeFullTrackObject>(
        items: [],
        total: 0,
        limit: limit ?? 20,
        hasMore: false,
        nextOffset: null,
      );
    }

    final raw = await _hetuMetadataSearch.invoke(
      "tracks",
      positionalArgs: [query],
      namedArgs: {
        "limit": limit,
        "offset": offset,
      }..removeWhere((key, value) => value == null),
    ) as Map;

    return SpotubePaginationResponseObject<SpotubeFullTrackObject>.fromJson(
      raw.cast<String, dynamic>(),
      (json) => SpotubeFullTrackObject.fromJson(json.cast<String, dynamic>()),
    );
  }
}
