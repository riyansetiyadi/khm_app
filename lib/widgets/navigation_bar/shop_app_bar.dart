import 'package:flutter/material.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const ShopAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.network(
        'https://simkhm.id/wonorejo/admin/dist/assets/img/khm.png',
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
