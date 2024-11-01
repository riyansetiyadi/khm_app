import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
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
              context.push('/home');
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.queue, color: Colors.blue),
            title: const Text('Daftar Antrian'),
            onTap: () {
              context.push('/pendaftaran');
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
            leading: Icon(Icons.question_answer, color: Colors.green),
            title: const Text('Konsultasi'),
            onTap: () {
              context.push(
                Uri(
                  path: '/webview',
                  queryParameters: {
                    'url': 'https://simkhm.id/wonorejo/kosmetik/login.php'
                  },
                ).toString(),
              );
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.miscellaneous_services, color: Colors.green),
            title: const Text('Layanan'),
            onTap: () {
              context.push('/layanan');
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.medical_services, color: Colors.red),
            title: const Text('Beli Obat (Segera Hadir)'),
            onTap: () {
              context.push(
                Uri(
                  path: '/webview',
                  queryParameters: {'url': 'https://simkhm.id/'},
                ).toString(),
              );
              Scaffold.of(context).closeDrawer();
            },
          ),
        ],
      ),
    );
  }
}
