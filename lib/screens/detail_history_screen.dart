import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:khm_app/extension/currency.dart';
import 'package:khm_app/extension/status_formatted.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/provider/transaction_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<TransactionProvider>(builder: (context, state, _) {
        switch (state.state) {
          case ResultState.loading:
            return Center(
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator(
                      radius: 20.0,
                    )
                  : const CircularProgressIndicator(),
            );
          case ResultState.initial:
            return ErrorRefresh(
              errorTitle: "Gagal mendapatkan transaksi",
            );
          case ResultState.error:
            return ErrorRefresh(
              errorTitle: "Gagal mendapatkan transaksi",
            );
          case ResultState.loaded:
            if (state.transaction?.isEmpty ?? true) {
              return ErrorRefresh(
                errorTitle: "Gagal mendapatkan transaksi",
              );
            } else {
              return detailTransaction(state);
            }
        }
      }),
    );
  }

  Column detailTransaction(TransactionProvider state) {
    final productProvider = context.watch<ProductProvider>();

    double totalHargaAsli = state.transaction!.fold(
        0.0,
        (sum, product) =>
            sum + (double.parse(product.harga) * double.parse(product.jumlah)));
    double totalBelanja = state.transaction!
        .fold(0.0, (sum, product) => sum + double.parse(product.subHarga));
    double totalDiskon = -(totalHargaAsli - totalBelanja);
    return Column(
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
                  state.transaction!.first.status.statusFormatted(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 15),
                Divider(thickness: 0.3),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nomor Nota'),
                    Row(
                      children: [
                        Text(state.transaction?.first.codeNota ?? ''),
                        SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: state.transaction?.first.codeNota ?? ''));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Nota copied to clipboard')),
                            );
                          },
                          icon: Icon(
                            Icons.file_copy,
                            color: Color(0xFF198754),
                            size: 20,
                          ),
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
                    Text(formatTanggal(state.transaction!.first.createdAt)),
                  ],
                ),
                SizedBox(height: 15),
                Divider(thickness: 0.3),
                SizedBox(height: 30),
                Text(
                  'Detail Produk',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                ...state.transaction!.map(
                  (product) {
                    double subHargaAsli = (double.parse(product.harga) *
                        double.parse(product.jumlah));
                    return InkWell(
                      onTap: () {
                        productProvider.getProduct(int.parse(product.produkId));
                        widget.onTapped(AppPage.detailProduct);
                      },
                      child: Card(
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
                                                product.produk,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                "${product.jumlah} barang",
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
                                                'Total harga',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                subHargaAsli.toRupiah(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                    );
                  },
                ),
                SizedBox(height: 20),
                Divider(thickness: 0.3),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bukti Pembayaran'),
                    (state.transaction!.first.buktiPembayaran != null)
                        ? Text('Lihat Foto')
                        : Text(
                            state.transaction!.first.status.statusFormatted()),
                  ],
                ),
                SizedBox(height: 20),
                Divider(thickness: 0.3),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Harga (${state.transaction!.length} Barang)'),
                    Text(totalHargaAsli.toRupiah())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Diskon'),
                    Text(totalDiskon.toRupiah())
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 0.3),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Belanja',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      totalBelanja.toRupiah(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
        if (state.transaction!.first.buktiPembayaran == null)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                await state.pickImage();
                widget.onTapped(AppPage.uploadBuktiPembayaran);
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
    );
  }

  String formatTanggal(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('d MMMM yyyy, HH:mm', 'id_ID');
    final String formattedDate = dateFormat.format(dateTime);
    return '$formattedDate WIB';
  }
}
