import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopDrawer extends StatelessWidget {
  const ShopDrawer({
    super.key,
  });

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
              context.push(
                Uri(
                  path: '/webview',
                  queryParameters: {
                    'url': 'https://simkhm.id/wonorejo/kosmetik/?halaman=home'
                  },
                ).toString(),
              );
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.brush, color: Colors.pink),
            title: const Text('Kosmetik'),
            onTap: () {
              context.push(
                Uri(
                  path: '/webview',
                  queryParameters: {
                    'url': 'https://simkhm.id/wonorejo/kosmetik/?halaman=shop'
                  },
                ).toString(),
              );
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital, color: Colors.pink),
            title: const Text('SIMKHM'),
            onTap: () {
              context.push('/home');
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.red),
            title: const Text('Tentang kami'),
            onTap: () {
              context.push('/kosmetik_about_us');
              Scaffold.of(context).closeDrawer();
            },
          ),
        ],
      ),
    );
  }
}
