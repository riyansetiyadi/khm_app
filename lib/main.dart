import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khm_app/utils/fcm_helper.dart';
import 'package:khm_app/utils/notification_helper.dart';
import 'package:khm_app/utils/webview_helper.dart';
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
  String mainUrl = 'https://simkhm.id/';
  int _selectedIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller = webviewHelper.initWebview(
      mainUrl: mainUrl,
      onLoadingChanged: (isLoading) {
        setState(() {
          _isLoading = isLoading;
        });
      },
    );
  }

  void _loadUrl(String url) {
    _controller.loadRequest(Uri.parse(url));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'SIMKHM',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: const Text(
                    'SIMKHM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.queue, color: Colors.blue),
                title: const Text('Daftar Antrian'),
                onTap: () {
                  _loadUrl('https://simkhm.id/daftar.php');
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ListTile(
                leading: Icon(Icons.brush, color: Colors.pink),
                title: const Text('Kosmetik'),
                onTap: () {
                  _loadUrl('https://simkhm.id/wonorejo/kosmetik/?halaman=shop');
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer, color: Colors.green),
                title: const Text('Konsultasi'),
                onTap: () {
                  _loadUrl('https://simkhm.id/wonorejo/kosmetik/login.php');
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.miscellaneous_services, color: Colors.green),
                title: const Text('Layanan'),
                onTap: () {
                  _loadUrl('https://simkhm.id/layanan.php');
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services, color: Colors.red),
                title: const Text('Beli Obat (Segera Hadir)'),
                onTap: () {
                  _loadUrl('https://simkhm.id/');
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
            ],
          ),
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard, color: Colors.black),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_quote, color: Colors.black),
              label: 'Antrianku',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_support, color: Colors.black),
              label: 'Admin',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
