import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomBar extends StatefulWidget {
  final Widget child;
  final String location;

  const ScaffoldWithBottomBar(
      {required this.child, required this.location, Key? key})
      : super(key: key);

  @override
  State<ScaffoldWithBottomBar> createState() => _ScaffoldWithBottomBarState();
}

class _ScaffoldWithBottomBarState extends State<ScaffoldWithBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          currentIndex: _getSelectedIndex(),
          backgroundColor: Colors.green,
          selectedItemColor: Color(0xFF198754),
          unselectedItemColor: Colors.white,
          onTap: (index) => _onItemTapped(index, context),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            ),
          ],
        ));
  }

  int _getSelectedIndex() {
    final String location = widget.location;
    if (location == '/') {
      return 0;
    }
    if (location == '/settings') {
      return 4;
    }
    if (location == '/login') {
      return 4;
    }
    if (location == '/register') {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/addroom');
        break;
      case 2:
        context.go('/shop');
        break;
      case 3:
        context.go('/cart');
        break;
      case 4:
        context.go('/setting');
        break;
    }
  }
}
