import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final WebViewController controller;
  const ShopDrawer(
      {super.key, required this.scaffoldKey, required this.controller});

  void _loadUrl(String url) {
    controller.loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                'KOSMETIK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: const Text('Home'),
            onTap: () {
              _loadUrl('https://simkhm.id/wonorejo/kosmetik/?halaman=home');
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
            leading: Icon(Icons.local_hospital, color: Colors.pink),
            title: const Text('SIMKHM'),
            onTap: () {
              _loadUrl('https://simkhm.id');
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.red),
            title: const Text('Tentang kami'),
            onTap: () {
              _loadUrl('https://simkhm.id/wonorejo/kosmetik/?halaman=about_us');
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
        ],
      ),
    );
  }
}
