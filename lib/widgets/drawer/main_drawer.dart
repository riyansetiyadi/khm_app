import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final WebViewController controller;
  const MainDrawer(
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
            leading: Icon(Icons.home, color: Colors.blue),
            title: const Text('Home'),
            onTap: () {
              _loadUrl('https://simkhm.id');
              scaffoldKey.currentState?.closeDrawer();
            },
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
            leading: Icon(Icons.miscellaneous_services, color: Colors.green),
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
    );
  }
}
