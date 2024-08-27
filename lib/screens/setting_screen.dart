import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final authRead = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/user.png',
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authRead.profile?.fullname ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        authRead.profile?.phoneNumber ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          context.push('/profile');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.person,
                                color: Color(0xFF198754),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Detail Profil',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFF198754),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          context.push('/registerkonsul');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.person_add,
                                color: Color(0xFF198754),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Perbarui Jenis Kelamin dan NIK',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFF198754),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          context.push('/registeraddress');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.person_add,
                                color: Color(0xFF198754),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Atur Alamat Pengiriman',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFF198754),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          context.go('/riwayat');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.history,
                                color: Color(0xFF198754),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Riwayat Transaksi',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFF198754),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await authRead.logout();
                        if (result) {
                          context.go('/login');
                        }
                      },
                      child: Text('Log Out'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 36),
                        backgroundColor: Color(0xFF198754),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
