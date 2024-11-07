import 'package:flutter/material.dart';
import 'package:khm_app/utils/webview_helper.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/drawer/kosmetik_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/kosmetik_bottom_bar.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';
import 'package:khm_app/widgets/navigation_bar/main_bottom_bar.dart';
import 'package:khm_app/widgets/navigation_bar/kosmetik_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  const WebviewScreen({
    super.key,
    required this.url,
  });

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final WebviewHelper webviewHelper = WebviewHelper();
  late final WebViewController _controller;
  bool _isLoading = false;
  String _titleAppBar = '';
  String _webTitle = '';

  @override
  void initState() {
    super.initState();

    _controller = webviewHelper.initWebview(
        initialUrl: widget.url,
        onLoadingChanged: (isLoading) {
          setState(() {
            _isLoading = isLoading;
          });
        },
        onUrlChanged: (url) {
          print(url);
          setState(() {
            if (url.startsWith("https://simkhm.id/wonorejo/kosmetik/")) {
              _webTitle = 'kosmetik';
            } else {
              _webTitle = 'simkhm';
            }
          });
        });
  }

  Widget buildDrawer(webtitle) {
    if (_webTitle == 'kosmetik') {
      return KosmetikDrawer();
    } else {
      return MainDrawer();
    }
  }

  PreferredSizeWidget buildAppBar(webtitle) {
    if (_webTitle == 'kosmetik') {
      return KosmetikAppBar();
    } else {
      return MainAppBar(title: _titleAppBar);
    }
  }

  Widget? buildBottomBar(webtitle) {
    if (_webTitle == 'kosmetik') {
      return KosmetikBottomBar();
    } else {
      return MainBottomBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(_webTitle),
      drawer: buildDrawer(_webTitle),
      bottomNavigationBar: buildBottomBar(_webTitle),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (!didPop) {
                  if (await _controller.canGoBack()) {
                    await _controller.goBack();
                  } else {
                    final navigator = Navigator.of(context);
                    navigator.pop();
                  }
                }
              },
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
