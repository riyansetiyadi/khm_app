import 'package:flutter/material.dart';
import 'package:khm_app/utils/enum_app_page.dart';

class DetailHistory extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const DetailHistory({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Detail Pesanan')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Status Pesanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  Divider(thickness: 0.3),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nomor Resi'),
                      Row(
                        children: [
                          Text('Nomor Resi'),
                          SizedBox(width: 5),
                          Icon(
                            Icons.file_copy,
                            color: Color(0xFF198754),
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tanggal Pembelian'),
                      Text('Tanggal, waktu'),
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(thickness: 0.3),
                  SizedBox(height: 30),
                  Text(
                    'Detail Produk',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/produk.png',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'nama produk',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'jumlah produk',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total belanja',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            'harga produk',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 0.3),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bukti Pembayaran'),
                      Text('Lihat Foto'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 0.3),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Total Harga (1 Barang)'), Text('Rp.')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Total Diskon'), Text('Rp.')],
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 0.3),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Belanja',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'Rp.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Action for button press
              },
              child: Text('Upload Bukti Transaksi'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 36),
                backgroundColor: Color(0xFF198754),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
