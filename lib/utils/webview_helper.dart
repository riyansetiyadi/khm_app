import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebviewHelper {
  static WebviewHelper? _instance;

  WebviewHelper._internal() {
    _instance = this;
  }

  factory WebviewHelper() => _instance ?? WebviewHelper._internal();

  WebViewController initWebview({
    required String initialUrl,
    required Function(bool) onLoadingChanged,
    Function(String)? onUrlChanged,
  }) {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            onLoadingChanged(true);
            if (onUrlChanged != null) onUrlChanged(url);
          },
          onPageFinished: (String url) {
            onLoadingChanged(false);
          },
          onNavigationRequest: (NavigationRequest request) async {
            final Uri url = Uri.parse(request.url);
            final String currentHost = Uri.parse(initialUrl).host;

            if (url.host != currentHost) {
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                await launchUrl(url, mode: LaunchMode.inAppWebView);
              }
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(initialUrl));

    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(const Color(0x80000000));
    }

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    return controller;
  }
}
