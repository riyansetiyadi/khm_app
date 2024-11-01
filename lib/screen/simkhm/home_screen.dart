import 'package:flutter/material.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';
import 'package:khm_app/widgets/navigation_bar/main_bottom_bar.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeSimkhmScreen extends StatefulWidget {
  const HomeSimkhmScreen({super.key});

  @override
  State<HomeSimkhmScreen> createState() => _HomeSimkhmScreenState();
}

class _HomeSimkhmScreenState extends State<HomeSimkhmScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late WebViewController _controller;
int _selectedIndex = 0; 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // key: _scaffoldKey,
        // appBar: AppBar(
        //   title: Text('SIMKHM'),
        //   leading: IconButton(
        //     icon: Icon(Icons.menu),
        //     onPressed: () {
        //       _scaffoldKey.currentState?.openDrawer();
        //     },
        //   ),
        // ),
        // drawer: MainDrawer(
        //   scaffoldKey: _scaffoldKey,
        //   controller: _controller,
        // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Image(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOuPYK2oy_VajJDRE_Y4S1qgC9WdLTVHmCbg&s'),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            SizedBox(height: 12),
            Text(
              'Layanan KHM',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image(
                    image:
                        NetworkImage('https://simkhm.id/assets/img/daftar.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image(
                    image: NetworkImage(
                        'https://simkhm.id/assets/img/kosmetik.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image(
                    image: NetworkImage(
                        'https://simkhm.id/assets/img/konsultasi.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image(
                    image: NetworkImage(
                        'https://simkhm.id/assets/img/layanan.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image(
                    image:
                        NetworkImage('https://simkhm.id/assets/img/obat.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12.0),
              width: double.infinity,
              color: Color(0XFF08592f),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Info Terkini',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                        'https://simkhm.id/assets/img/group2.png',
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: 50),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Yuk, Segera Belanja Kosmestik Sekarang!',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Klik di sini ya!'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Container(
              color: Color(0XFF08592f),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hubungi Kami',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'KHM Wonorejo : ',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.whatsapp),
                          color: Colors.white,
                          onPressed: () {}),
                      Text('CS +62 822 3388 0001',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 0),
                  Row(
                    children: [
                      Text(
                        'KHM Klakah : ',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.whatsapp),
                          color: Colors.white,
                          onPressed: () {}),
                      Text('CS +62 813 5555 0275',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'KHM Tunjung :',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.whatsapp),
                          color: Colors.white,
                          onPressed: () {}),
                      Text('CS +62 812 3457 1010',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ikuti Kami',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.instagram),
                          color: Colors.white,
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook),
                          color: Colors.white,
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.tiktok),
                          color: Colors.white,
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.youtube),
                          color: Colors.white,
                          onPressed: () {}),
                    ],
                  ),
                  SizedBox(height: 10),
                  Image(
                    image: NetworkImage(
                        'https://simkhm.id/assets/img/20230831_110803.png'),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              
            ),
          ],
        ),
      ),
       bottomNavigationBar: MainBottomBar(
        initiateIndex: _selectedIndex, // Mengoper indeks yang dipilih
        onTap: _onItemTapped,   // Mengoper fungsi untuk menangani ketukan
      ),
    ));
  }
}
