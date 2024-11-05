import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSimkhmScreen extends StatefulWidget {
  const HomeSimkhmScreen({super.key});

  @override
  State<HomeSimkhmScreen> createState() => _HomeSimkhmScreenState();
}

class _HomeSimkhmScreenState extends State<HomeSimkhmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SIMKHM'),
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Image(
                    image: AssetImage('assets/images/benner.png'),
                    height: 150,
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
                spacing: 15,
                runSpacing: 15,
                children: [
                  InkWell(
                    onTap: () {
                      context.push('/pendaftaran');
                    },
                    child: Image(
                      image: NetworkImage(
                          'https://simkhm.id/assets/img/daftar.png'),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push(
                        Uri(
                          path: '/webview',
                          queryParameters: {
                            'url':
                                'https://simkhm.id/wonorejo/kosmetik/?halaman=shop'
                          },
                        ).toString(),
                      );
                    },
                    child: Image(
                      image: NetworkImage(
                          'https://simkhm.id/assets/img/kosmetik.png'),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push(
                        Uri(
                          path: '/webview',
                          queryParameters: {
                            'url':
                                'https://simkhm.id/wonorejo/kosmetik/login.php'
                          },
                        ).toString(),
                      );
                    },
                    child: Image(
                      image: NetworkImage(
                          'https://simkhm.id/assets/img/konsultasi.png'),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/layanan');
                    },
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () {
                              context.push(
                                Uri(
                                  path: '/webview',
                                  queryParameters: {
                                    'url':
                                        'https://simkhm.id/wonorejo/kosmetik/?halaman=shop'
                                  },
                                ).toString(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 240, 218, 22),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Klik di sini ya!',
                              style: TextStyle(color: Colors.black),
                            ),
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
                          onPressed: () async {
                            final Uri InstagramUri = Uri.parse(
                                "https://www.instagram.com/husadamuliaofficial/");
                            if (await canLaunchUrl(InstagramUri)) {
                              await launchUrl(InstagramUri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print("Could not launch Instagram");
                            }
                          },
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook),
                          color: Colors.white,
                          onPressed: () async {
                            final Uri FacebookUri = Uri.parse(
                                "https://www.facebook.com/profile.php?id=61553748481575");
                            if (await canLaunchUrl(FacebookUri)) {
                              await launchUrl(FacebookUri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print("Could not launch Facebook");
                            }
                          },
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.tiktok),
                          color: Colors.white,
                          onPressed: () async {
                            final Uri TiktokUri = Uri.parse(
                                "https://www.tiktok.com/@husada_mulia");
                            if (await canLaunchUrl(TiktokUri)) {
                              await launchUrl(TiktokUri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print("Could not launch Tiktok");
                            }
                          },
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.youtube),
                          color: Colors.white,
                          onPressed: () async {
                            final Uri YoutubeUri = Uri.parse(
                                "https://www.youtube.com/@sahabatmuliaofficial1463");
                            if (await canLaunchUrl(YoutubeUri)) {
                              await launchUrl(YoutubeUri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print("Could not launch Youtube");
                            }
                          },
                        ),
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
          initiateIndex: 0,
        ));
  }
}
