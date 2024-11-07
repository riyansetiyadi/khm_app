import 'package:flutter/material.dart';

class KosmetikAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const KosmetikAppBar({
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
