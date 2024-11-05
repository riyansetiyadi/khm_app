import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';
import 'package:khm_app/widgets/navigation_bar/main_bottom_bar.dart';

class PendaftaranPoliScreen extends StatefulWidget {
  const PendaftaranPoliScreen({super.key});

  @override
  State<PendaftaranPoliScreen> createState() => _PendaftaranPoliScreenState();
}

class _PendaftaranPoliScreenState extends State<PendaftaranPoliScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'SIMKHM',
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: MainBottomBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Pendaftaran Poli Online',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.network(
                          'https://wedangtech.my.id/WhatsApp%20Image%202024-07-15%20at%2015.04.18.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Klinik Husada Mulia Wonorejo',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 6, 86, 235),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            context.push(
                              Uri(
                                path: '/webview',
                                queryParameters: {
                                  'url':
                                      'https://simkhm.id/wonorejo/pasien/login.php'
                                },
                              ).toString(),
                            );
                          },
                          child: Text('Kunjungi',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.network(
                          'https://husadamulia.com/gambar/klakah.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Klinik Husada Mulia Klakah',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 6, 86, 235),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            context.push(
                              Uri(
                                path: '/webview',
                                queryParameters: {
                                  'url':
                                      'https://simkhm.id/klakah/pasien/login.php'
                                },
                              ).toString(),
                            );
                          },
                          child: Text('Kunjungi',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.network(
                          'https://husadamulia.com/gambar/klakah.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Klinik Husada Mulia Tunjung',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 6, 86, 235),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            context.push(
                              Uri(
                                path: '/webview',
                                queryParameters: {
                                  'url':
                                      'https://simkhm.id/tunjung/pasien/login.php'
                                },
                              ).toString(),
                            );
                          },
                          child: Text('Kunjungi',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
