import 'package:flutter/material.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const SettingScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      Row(
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
                                'Nama Lengkap',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'no telp',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          widget.onTapped(AppPage.profile);
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
                                'Profile',
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
                      SizedBox(height: 15),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          widget.onTapped(AppPage.registerkonsul);
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
                              'Register Jenis Kelamin dan NIK',
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
                      ),),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          widget.onTapped(AppPage.registeraddress);
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
                              'Register Alamat',
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
                      ),),
                      SizedBox(height: 15),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          widget.onTapped(AppPage.riwayat);
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
                      ),),
                      SizedBox(height: 15),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          final authRead = context.read<AuthProvider>();
                          final result = await authRead.logout();
                          if (result) {
                            widget.onTapped(AppPage.login);
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
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
