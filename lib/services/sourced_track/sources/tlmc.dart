import 'package:backend_client_api/api.dart';
import 'package:spotube/models/database/database.dart';
import 'package:spotube/models/playback/track_sources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotube/services/logger/logger.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/mapping_utils.dart';
import 'package:spotube/services/sourced_track/enums.dart';
import 'package:spotube/services/sourced_track/exceptions.dart';
import 'package:spotube/services/sourced_track/sourced_track.dart';

class TlmcSourcedTrack extends SourcedTrack {
  TlmcSourcedTrack({
    required super.ref,
    required super.source,
    required super.siblings,
    required super.info,
    required super.query,
    required super.sources,
  });

  static Future<SourcedTrack> fetchFromTrack({
    required TrackSourceQuery query,
    required Ref ref,
  }) async {
    var client = ApiClient(basePath: 'https://staging-api.marisad.me');
    var tracksApi = TrackApi(client);
    var response = await tracksApi.getTrack(query.id);

    if (response == null) {
      throw TrackNotFoundError(query);
    }

    AppLogger.log.i("Fetched track - ID: ${response.id}");
    AppLogger.log.i("Title: ${response.name!.default_}");

    // Adaptive streaming URLs - supports both HLS and DASH formats
    final hlsUrl =
        "https://staging-api.marisad.me/api/asset/track/${response.id}/hls";
    final dashUrl =
        "https://staging-api.marisad.me/api/asset/track/${response.id}/dash/manifest.mpd";

    AppLogger.log.i("HLS URL (master): $hlsUrl");
    AppLogger.log.i("DASH URL (manifest): $dashUrl");

    final sourcedTrack = TlmcSourcedTrack(
      ref: ref,
      source: AudioSource.tlmc,
      siblings: [],
      info: TrackSourceInfo(
        id: response.id!,
        title: response.name!.default_,
        artists:
            response.album?.albumArtist?.map((e) => e.name).join(",") ?? "",
        thumbnail: "<Placeholder>",
        pageUrl: "<Placeholder>",
        durationMs: TlmcToSpotubeMappingUtils.durationStringToMilliseconds(
          response.duration!,
        ),
      ),
      query: query,
      sources: [
        // HLS Master playlist
        TrackSource(
          url: hlsUrl,
          quality: SourceQualities.high,
          codec: SourceCodecs.m4a,
          bitrate: "adaptive",
        ),

        // Try media playlist
        // TrackSource(
        //   url: "$hlsUrl/320k/playlist.m3u8?generated=true",
        //   quality: SourceQualities.high,
        //   codec: SourceCodecs.m4a,
        //   bitrate: "320k",
        // ),
        // TrackSource(
        //   url: "$hlsUrl/192k/playlist.m3u8?generated=true",
        //   quality: SourceQualities.high,
        //   codec: SourceCodecs.m4a,
        //   bitrate: "192k",
        // ),
      ],
    );

    return sourcedTrack;
  }

  static Future<List<SiblingType>> fetchSiblings({
    required TrackSourceQuery query,
    required Ref ref,
  }) async {
    return [];
  }

  @override
  Future<SourcedTrack> copyWithSibling() {
    // TODO: implement copyWithSibling
    throw UnimplementedError();
  }

  @override
  Future<SourcedTrack> refreshStream() async {
    throw UnimplementedError();
  }

  @override
  Future<SourcedTrack?> swapWithSibling(TrackSourceInfo sibling) {
    // TODO: implement swapWithSibling
    throw UnimplementedError();
  }
}
