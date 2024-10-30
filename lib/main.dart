import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khm_app/utils/fcm_helper.dart';
import 'package:khm_app/utils/notification_helper.dart';
import 'package:khm_app/utils/webview_helper.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/drawer/shop_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';
import 'package:khm_app/widgets/navigation_bar/main_bottom_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final FcmHelper fcmHelper = FcmHelper();

  String? selectedNotificationPayload;

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    if (selectedNotificationPayload != null) {
      print(selectedNotificationPayload);
    }
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await fcmHelper.initFcm(flutterLocalNotificationsPlugin);

  runApp(const KhmApp());
}

class KhmApp extends StatefulWidget {
  const KhmApp({Key? key}) : super(key: key);

  @override
  State<KhmApp> createState() => _KhmAppState();
}

class _KhmAppState extends State<KhmApp> {
  final WebviewHelper webviewHelper = WebviewHelper();
  late final WebViewController _controller;
  bool _isLoading = false;
  String _url = 'https://simkhm.id/';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller = webviewHelper.initWebview(
      initialUrl: _url,
      onLoadingChanged: (isLoading) {
        setState(() {
          _isLoading = isLoading;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik Husada Mulia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: scaffoldKey,
        appBar: MainAppBar(),
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
        body: Stack(
          children: [
            PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (await _controller.canGoBack()) {
                  await _controller.goBack();
                } else {
                  SystemNavigator.pop();
                }
              },
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: MainBottomBar(),
      ),
    );
  }
}
