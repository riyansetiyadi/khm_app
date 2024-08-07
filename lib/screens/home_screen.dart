import 'package:flutter/material.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const HomeScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("keluar"),
          onPressed: () async {
            // final authRead = context.read<AuthProvider>();
            // final result = await authRead.logout();
            // if (result) {
            widget.onTapped(AppPage.login);
            // }
          },
        ),
      ),
    );
  }
}
