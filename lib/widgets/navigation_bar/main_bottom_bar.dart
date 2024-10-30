import 'package:flutter/material.dart';

class MainBottomBar extends StatefulWidget {
  final int? initiateIndex;
  const MainBottomBar({
    super.key,
    this.initiateIndex,
  });

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.initiateIndex ?? 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
