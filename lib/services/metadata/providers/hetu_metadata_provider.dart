import 'dart:typed_data';

import 'package:hetu_otp_util/hetu_otp_util.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_spotube_plugin/hetu_spotube_plugin.dart';
import 'package:hetu_std/hetu_std.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/apis/localstorage.dart';
import 'package:spotube/services/metadata/interfaces/index.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_auth_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_album_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_artist_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_browse_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_core_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_playlist_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_search_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_track_endpoint.dart';
import 'package:spotube/services/metadata/endpoints/hetu/hetu_user_endpoint.dart';

/// Hetu-based implementation of MetadataProvider
class HetuMetadataProvider implements MetadataProvider {
  static final pluginApiVersion = Version.parse("1.0.0");

  final PluginConfiguration _config;
  final Uint8List _byteCode;
  final Hetu? _hetu;

  late final MetadataAuthEndpointInterface _auth;
  late final MetadataAlbumEndpointInterface _album;
  late final MetadataArtistEndpointInterface _artist;
  late final MetadataBrowseEndpointInterface _browse;
  late final MetadataSearchEndpointInterface _search;
  late final MetadataPlaylistEndpointInterface _playlist;
  late final MetadataTrackEndpointInterface _track;
  late final MetadataUserEndpointInterface _user;
  late final MetadataCoreEndpointInterface _core;

  bool _isInitialized = false;

  HetuMetadataProvider._(this._config, this._byteCode, this._hetu) {
    if (_hetu == null) {
      throw ArgumentError.notNull("hetu");
    }

    _auth = HetuAuthEndpoint(_hetu!);
    _album = HetuAlbumEndpoint(_hetu!);
    _artist = HetuArtistEndpoint(_hetu!);
    _browse = HetuBrowseEndpoint(_hetu!);
    _search = HetuSearchEndpoint(_hetu!);
    _playlist = HetuPlaylistEndpoint(_hetu!);
    _track = HetuTrackEndpoint(_hetu!);
    _user = HetuUserEndpoint(_hetu!);
    _core = HetuCoreEndpoint(_hetu!);
  }

  @override
  PluginConfiguration get config => _config;

  @override
  String get apiVersion => pluginApiVersion.toString();

  @override
  bool get isInitialized => _isInitialized;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    final sharedPreferences = await SharedPreferences.getInstance();

    _hetu!.init();

    HetuStdLoader.loadBindings(_hetu!);
    HetuSpotubePluginLoader.loadBindings(
      _hetu!,
      localStorageImpl: SharedPreferencesLocalStorage(
        sharedPreferences,
        _config.slug,
      ),
      onNavigatorPush: (route) {
        // Navigation callback - can be implemented if needed
        return Future.value();
      },
      onNavigatorPop: () {
        // Navigation callback - can be implemented if needed
      },
      onShowForm: (title, fields) async {
        // Form callback - can be implemented if needed
        return <Map<String, dynamic>>[];
      },
    );

    await HetuStdLoader.loadBytecodeFlutter(_hetu!);
    await HetuOtpUtilLoader.loadBytecodeFlutter(_hetu!);
    await HetuSpotubePluginLoader.loadBytecodeFlutter(_hetu!);

    _hetu!.loadBytecode(bytes: _byteCode, moduleName: "plugin");
    _hetu!.eval("""
      import "module:plugin" as plugin

      var Plugin = plugin.${_config.entryPoint}

      var metadataPlugin = Plugin()
      """);

    _isInitialized = true;
  }

  @override
  Future<void> dispose() async {
    _isInitialized = false;
    // Hetu cleanup if needed
  }

  @override
  MetadataAuthEndpointInterface get auth => _auth;

  @override
  MetadataAlbumEndpointInterface get album => _album;

  @override
  MetadataArtistEndpointInterface get artist => _artist;

  @override
  MetadataBrowseEndpointInterface get browse => _browse;

  @override
  MetadataSearchEndpointInterface get search => _search;

  @override
  MetadataPlaylistEndpointInterface get playlist => _playlist;

  @override
  MetadataTrackEndpointInterface get track => _track;

  @override
  MetadataUserEndpointInterface get user => _user;

  @override
  MetadataCoreEndpointInterface get core => _core;

  /// Factory method to create a HetuMetadataProvider
  static Future<HetuMetadataProvider> create(
    PluginConfiguration config,
    Uint8List byteCode,
  ) async {
    final hetu = Hetu();
    return HetuMetadataProvider._(config, byteCode, hetu);
  }
}
