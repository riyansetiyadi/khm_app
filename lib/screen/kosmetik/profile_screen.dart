import 'package:flutter/material.dart';
import 'package:khm_app/provider/auth_kosmetik_provider.dart';
import 'package:provider/provider.dart';

class ProfileKosmetikScreen extends StatefulWidget {
  const ProfileKosmetikScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileKosmetikScreen> createState() => _ProfileKosmetikScreenState();
}

class _ProfileKosmetikScreenState extends State<ProfileKosmetikScreen> {
  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthKosmetikProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Image.asset(
              'assets/images/user.png',
              height: 100,
              fit: BoxFit.contain,
            ),
            Container(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nama Lengkap',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authWatch.profile?.fullname ?? '',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authWatch.profile?.email ?? '',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'NIK',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authWatch.profile?.idNumber ?? '',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal Lahir',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authWatch.profile?.dateBirth ?? '',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Umur',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authWatch.profile?.age ?? '',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No. Telepon',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authWatch.profile?.phoneNumber ?? '',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Alamat Lengkap',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authWatch.profile?.address ?? '',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
