import 'package:backend_client_api/api.dart';
import 'package:spotube/models/database/database.dart';
import 'package:spotube/models/playback/track_sources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotube/provider/user_preferences/user_preferences_provider.dart';
import 'package:spotube/services/logger/logger.dart';
import 'package:spotube/services/metadata/endpoints/tlmc/mapping_utils.dart';
import 'package:spotube/services/sourced_track/enums.dart';
import 'package:spotube/services/sourced_track/exceptions.dart';
import 'package:spotube/services/sourced_track/sourced_track.dart';

final tlmcClientProvider = Provider<ApiClient>(
  (ref) {
    final tlmcInstance = ref.watch(
      userPreferencesProvider.select((s) => s.tlmcInstance),
    );
    return ApiClient(basePath: tlmcInstance);
  },
);

class TlmcSourcedTrack extends SourcedTrack {
  TlmcSourcedTrack({
    required super.ref,
    required super.source,
    required super.siblings,
    required super.info,
    required super.query,
    required super.sources,
  });

  static String getHlsUrl(String trackId, String tlmcInstance) {
    return "$tlmcInstance/api/asset/track/$trackId/hls";
  }

  static Future<SourcedTrack> fetchFromTrack({
    required TrackSourceQuery query,
    required Ref ref,
  }) async {
    final client = ref.read(tlmcClientProvider);
    final tlmcInstance = ref.read(userPreferencesProvider).tlmcInstance;

    var tracksApi = TrackApi(client);
    var response = await tracksApi.getTrack(query.id);

    if (response == null) {
      throw TrackNotFoundError(query);
    }

    // Adaptive streaming URLs - supports both HLS and DASH formats
    final hlsUrl = getHlsUrl(query.id, tlmcInstance);

    AppLogger.log.i("HLS URL (master): $hlsUrl");

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
    return this;
  }

  @override
  Future<SourcedTrack?> swapWithSibling(TrackSourceInfo sibling) {
    // TODO: implement swapWithSibling
    throw UnimplementedError();
  }
}
