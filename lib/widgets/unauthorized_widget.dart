import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cart.png',
            width: 100,
            height: 100,
          ),
          Text(
            'Wah, kamu belum login/register nih',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          Text(
            'Yuk, segera login/register!',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: Text('Login Sekarang'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF198754),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
