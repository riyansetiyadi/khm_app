import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/utils/webview_helper.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/drawer/shop_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';
import 'package:khm_app/widgets/navigation_bar/main_bottom_bar.dart';
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MainAppBar(title: _titleAppBar),
      drawer: FutureBuilder(
        future: _controller.currentUrl(),
        builder: (context, snapshot) {
          String url = snapshot.data ?? '';
          if (url.startsWith("https://simkhm.id/wonorejo/kosmetik/")) {
            return ShopDrawer(
                scaffoldKey: scaffoldKey, controller: _controller);
          } else {
            return MainDrawer(
                scaffoldKey: scaffoldKey, controller: _controller);
          }
        },
      ),
      bottomNavigationBar: const MainBottomBar(),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (await _controller.canGoBack()) {
                  await _controller.goBack();
                } else {
                  if (context.mounted) {
                    context.go('/home');
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
