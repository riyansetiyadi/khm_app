import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KosmetikBottomBar extends StatefulWidget {
  final int? initiateIndex;
  const KosmetikBottomBar({
    super.key,
    this.initiateIndex,
  });

  @override
  State<KosmetikBottomBar> createState() => _KosmetikBottomBarState();
}

class _KosmetikBottomBarState extends State<KosmetikBottomBar> {
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

    switch (index) {
      case 0:
        context.push('/home-kosmetik');
        break;
      case 1:
        context.push('/shop-kosmetik');
        break;
      case 2:
        context.push('/setting-kosmetik');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.request_quote, color: Colors.black),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.black),
          label: 'Profil',
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
