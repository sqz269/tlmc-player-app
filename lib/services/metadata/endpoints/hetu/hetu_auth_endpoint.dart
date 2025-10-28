import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:spotube/services/metadata/interfaces/auth_endpoint.dart';
import 'package:spotube/utils/platform.dart';

/// Hetu implementation of MetadataAuthEndpointInterface
class HetuAuthEndpoint implements MetadataAuthEndpointInterface {
  final Hetu _hetu;

  HetuAuthEndpoint(this._hetu);

  @override
  Stream get authStateStream =>
      _hetu.eval("metadataPlugin.auth.authStateStream");

  @override
  Future<void> authenticate() async {
    await _hetu.eval("metadataPlugin.auth.authenticate()");
  }

  @override
  bool isAuthenticated() {
    return _hetu.eval("metadataPlugin.auth.isAuthenticated()") as bool;
  }

  @override
  Future<void> logout() async {
    await _hetu.eval("metadataPlugin.auth.logout()");
    if (kIsMobile) {
      WebStorageManager.instance().deleteAllData();
      CookieManager.instance().deleteAllCookies();
    }
    if (kIsDesktop) {
      await WebviewWindow.clearAll();
    }
  }
}
