import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khm_app/widgets/drawer/shop_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/shop_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopAppBar(),
      drawer: ShopDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                'https://husadamulia.com/gambar/klakah.jpeg',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tentang Klinik Husada Mulia',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Klinik Husada Mulia',
                        style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 15, 116, 18),
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            ' merupakan klinik pratama rawat inap, dimana keunggulan kami adalah seluruh kamar isi 1 pasien, sehingga lebih nyaman dan meminimalisir penularan penyakit',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Dokter',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            FaIcon(
              FontAwesomeIcons.userDoctor,
              size: 50.0,
              color: const Color.fromARGB(255, 15, 116, 18),
            ),
            SizedBox(height: 10),
            Text(
              'Klinik Husada Mulia kini memperkenalkan aplikasi terbaru kami yang memungkinkan Anda untuk berkonsultasi langsung dengan dokter-dokter ahli secara gratis! Manfaatkan kesempatan ini untuk mendapatkan saran profesional tentang produk kosmetik dan perawatan kulit yang sesuai dengan kebutuhan Anda. Dengan kombinasi produk berkualitas dengan harga terjangkau dan bimbingan dari para ahli, Klinik Husada Mulia memastikan Anda tampil cantik dan percaya diri setiap saat. Unduh aplikasi kami dan temukan kecantikan alami Anda hari ini!',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 30),
            Text(
              'Ekonomis',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            FaIcon(
              FontAwesomeIcons.moneyBill1,
              size: 50.0,
              color: const Color.fromARGB(255, 15, 116, 18),
            ),
            SizedBox(height: 10),
            Text(
              'Klinik Husada Mulia menawarkan rangkaian produk kosmetik dengan harga terjangkau tanpa kompromi pada kualitas. Dengan bahan-bahan pilihan dan formula inovatif, setiap produk dirancang untuk memberikan hasil optimal, menjadikan perawatan kecantikan yang efektif dapat diakses oleh semua orang. Temukan rahasia kecantikan alami Anda dengan Klinik Husada Mulia – pilihan cerdas untuk perawatan kecantikan yang ramah di kantong!',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 30),
            Text(
              'Pelayanan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            FaIcon(
              FontAwesomeIcons.paste,
              size: 50.0,
              color: const Color.fromARGB(255, 15, 116, 18),
            ),
            SizedBox(height: 10),
            Text(
              'Klinik Husada Mulia mempersembahkan layanan lengkap untuk kecantikan Anda dengan harga terjangkau, konsultasi kosmetik gratis melalui aplikasi, dan kini, pelayanan 24 jam! Kami memastikan bahwa perawatan kulit dan konsultasi dengan dokter ahli selalu tersedia kapan pun Anda butuhkan. Baik siang maupun malam, Anda dapat mengandalkan Klinik Husada Mulia untuk solusi kecantikan yang cepat, profesional, dan terjangkau. Temukan kenyamanan perawatan 24/7 bersama kami dan bersiaplah untuk tampil memukau setiap saat!',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              color: const Color.fromARGB(255, 219, 219, 219),
              thickness: 1.0,
            ),
            Image(
                image: NetworkImage(
                    'https://wedangtech.my.id/Desain%20tanpa%20judul%20%286%29.png')),
            SizedBox(
              height: 18,
            ),
            Text('Tim Dokter Husada Mulia', style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () {
                context.push(
                  Uri(
                    path: '/webview',
                    queryParameters: {
                      'url': 'https://simkhm.id/wonorejo/kosmetik/?halaman=shop'
                    },
                  ).toString(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 35, 94, 37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Tim Dokter',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: const Color.fromARGB(255, 219, 219, 219),
              thickness: 1.0,
            ),
            SizedBox(height: 20),
            Text(
              'Temukan Kami',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Klinik Husada Mulia Wonorejo',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 35, 94, 37)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                            'Jl. Nasional 25, Krajan, Wonorejo, Kec. Kedungjajang, Kabupaten Lumajang, Jawa Timur 67358'),
                        ElevatedButton(
                          onPressed: () async {
                            final Uri MapsUri = Uri.parse(
                                "https://www.google.com/maps?ll=-8.082487,113.222733&z=13&t=m&hl=id&gl=ID&mapclient=embed&cid=14695811650495879814");
                            if (await canLaunchUrl(MapsUri)) {
                              await launchUrl(MapsUri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print("Could not launch Maps");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 35, 94, 37),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Lihat Lokasi',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Klinik Husada Mulia Klakah',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 35, 94, 37)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                            'Jl. Raya Lumajang - Probolinggo, Kec. Klakah, Kabupaten Lumajang, Jawa Timur 67356'),
                        ElevatedButton(
                          onPressed: () async {
                            final Uri MapsUri = Uri.parse(
                                "https://www.google.com/maps?ll=-8.00704,113.24439&z=15&t=m&hl=id&gl=ID&mapclient=embed&cid=1197288916292994637");
                            if (await canLaunchUrl(MapsUri)) {
                              await launchUrl(MapsUri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print("Could not launch Maps");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 35, 94, 37),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Lihat Lokasi',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Klinik Husada Mulia Tunjung',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 35, 94, 37)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                            'Jl. Tunjung, Krajan Dua, Tunjung, Kec. Randuagung, Kabupaten Lumajang, Jawa Timur 67354'),
                        ElevatedButton(
                          onPressed: () async {
                            final Uri MapsUri = Uri.parse(
                                "https://www.google.com/maps?ll=-8.078039,113.333292&z=10&t=m&hl=id&gl=ID&mapclient=embed&cid=15901907758921733217");
                            if (await canLaunchUrl(MapsUri)) {
                              await launchUrl(MapsUri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print("Could not launch Maps");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 35, 94, 37),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Lihat Lokasi',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '© Solverra IT 2024.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
