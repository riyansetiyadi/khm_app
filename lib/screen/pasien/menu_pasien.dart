import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MenuPasienScreen extends StatefulWidget {
  const MenuPasienScreen({super.key});

  @override
  State<MenuPasienScreen> createState() => _MenuPasienScreenState();
}

class _MenuPasienScreenState extends State<MenuPasienScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        // ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Selamat Datang, ',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Nama Pasien',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Jadwal Hari Ini ',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(255, 4, 1, 52)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                ' | No. Antrian',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.fileText,
                                  size: 30.0,
                                  color: const Color.fromARGB(255, 15, 116, 18),
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  softWrap: true,
                                  'Anda Belum Ada Jadwal Booking Hari Ini',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Riwayat Kedatangan',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color:
                                          const Color.fromARGB(255, 4, 1, 52)),
                                ),
                                TextSpan(
                                  text: ' Nama Pasien :',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color:
                                          const Color.fromARGB(255, 4, 1, 52)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.user,
                                  size: 30.0,
                                  color: const Color.fromARGB(255, 15, 116, 18),
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  '0',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: const Color.fromARGB(
                                          255, 15, 116, 18)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  context.push('/');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.commentDots,
                          size: 30.0,
                          color: const Color.fromARGB(255, 15, 116, 18),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Chat Konsultasi',
                          style: TextStyle(
                              color: Color.fromARGB(255, 15, 116, 18),
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.push('/daftar_pasien_lama');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.usersLine,
                                size: 30.0,
                                color: const Color.fromARGB(255, 15, 116, 18),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Pendaftaran',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 15, 116, 18),
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.push('/riwayat_registrasi');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.userClock,
                                size: 30.0,
                                color: const Color.fromARGB(255, 15, 116, 18),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Riwayat Daftar',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 15, 116, 18),
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  context.push('/');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          size: 30.0,
                          color: const Color.fromARGB(255, 15, 116, 18),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: Color.fromARGB(255, 15, 116, 18),
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
