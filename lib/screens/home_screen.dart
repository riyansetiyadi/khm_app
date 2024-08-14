import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const HomeScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    final productProvider = context.read<ProductProvider>();

    Future.microtask(() async {
      productProvider.getNewProductsHome();
      productProvider.getBestSellerProductsHome();
    });

    _pageController.addListener(() {
      final page = _pageController.page;
      if (page != null) {
        setState(() {
          _currentPage = page.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0.5),
        body: Center(
            child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              height: 180,
              width: 450,
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  buildBanner('assets/images/banner1.png'),
                  buildBanner('assets/images/banner2.png'),
                  buildBanner('assets/images/banner3.png'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 3; i++) buildIndicator(i == _currentPage),
              ],
            ),
            SizedBox(height: 10.0),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Konsultasi Masalahmu Dengan Dokter Ahli Kami!',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Atasi Masalah Kecantikanmu Seketika dengan Konsultasi Dokter di SIMKHM',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Ubah mimpi kecantikanmu menjadi kenyataan dengan ',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Konsultasi Dokter Ahli Di Aplikasi SIMKHM. ',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Dapatkan solusi instan untuk berbagai masalah kulit, rambut, dan kecantikan lainnya.',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Mulai Sekarang',
                  style: TextStyle(
                    fontSize: 12,
                  )),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(20, 30),
                backgroundColor: Color(0xFF198754),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 0.3,
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Produk Terbaru',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ]))),
            SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Consumer<ProductProvider>(builder: (context, state, _) {
                  print(state.state);
                  if (state.state == ResultState.loading &&
                      state.newProducts == null) {
                    return Center(
                      child: defaultTargetPlatform == TargetPlatform.iOS
                          ? const CupertinoActivityIndicator(
                              radius: 20.0,
                            )
                          : const CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.error ||
                      state.newProducts == null) {
                    return ErrorRefresh(
                      errorTitle: state.message ?? '',
                      refreshTitle: 'Refresh',
                      onPressed: () async {
                        await state.getNewProductsHome();
                      },
                    );
                  } else if (state.state == ResultState.loaded ||
                      state.newProducts != null) {
                    return Row(
                        children: state.newProducts!.map((product) {
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/produk.png',
                              fit: BoxFit.contain,
                              height: 120,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.nama_produk ?? '',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                  Text(product.deskripsi ?? '',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey)),
                                  Text('Rp. ${product.harga ?? ''}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList());
                  } else {
                    return ErrorRefresh(
                      errorTitle: state.message ?? '',
                      refreshTitle: 'Refresh',
                      onPressed: () async {
                        await state.getNewProductsHome();
                      },
                    );
                  }
                }),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 0.3,
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Produk Terlaris',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ]))),
            SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/produk.png',
                          fit: BoxFit.contain,
                          height: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('nama produk',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              Text('keterangan',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              Text('Rp. 000.000',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('Produk Lainnya',
                  style: TextStyle(
                    fontSize: 12,
                  )),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(20, 30),
                backgroundColor: Color(0xFF198754),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 0.3,
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  color: Color.fromRGBO(1, 125, 51, 1),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Sistem Informasi Manajemen Klinik Husada Mulia',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '500+',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Produk Terjual',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '30+',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 70),
                                  Text(
                                    'Varian Produk',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 70),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '200+',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 70),
                                  Text(
                                    'Pengguna',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 70),
                                ],
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/orang.png',
                          width: 170,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // SizedBox(height: 15),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Konsultasi dengan Dokter Ahli',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Hanya di SIMKHM!',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Konsultasi',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  )),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 20),
                                backgroundColor: Color(0xFF198754),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        )));
  }

  Widget buildBanner(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: double.infinity,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: 200,
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 8.0 : 5.0,
      height: isActive ? 8.0 : 5.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
