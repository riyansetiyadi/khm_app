import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/utils/list_bottom_nav_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        currentIndex: widget.child.currentIndex,
        backgroundColor: Colors.green,
        selectedItemColor: Color(0xFF198754),
        unselectedItemColor: Colors.white,
        onTap: (index) {
          String? path = widget.child.route.branches[index].defaultRoute?.path;
          print(path);
          if (bottomNavPages.contains(path))
            widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            );
          else {
            context.push(path ?? '/notfound');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.store_rounded), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
