import 'package:flutter/material.dart';
import 'package:khm_app/utils/enum_app_page.dart';

class UnauthorizedPage extends StatelessWidget {
  final void Function(AppPage) onTapped;
  const UnauthorizedPage({
    super.key,
    required this.onTapped,
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
              onTapped(AppPage.login);
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
