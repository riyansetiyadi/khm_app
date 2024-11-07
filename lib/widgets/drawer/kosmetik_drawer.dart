import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KosmetikDrawer extends StatelessWidget {
  const KosmetikDrawer({
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
              context.push('/home-kosmetik');
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(Icons.brush, color: Colors.pink),
            title: const Text('Kosmetik'),
            onTap: () {
              context.push('/shop-kosmetik');
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
