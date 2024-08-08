import 'package:flutter/material.dart';
import 'package:khm_app/utils/enum_app_page.dart';

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
      body: Center(child: Text('Halo')),
    );
  }
}
