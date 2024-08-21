import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/history_transaction_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/empty_shop_widget.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:khm_app/widgets/unauthorized_widget.dart';
import 'package:provider/provider.dart';

class RiwayatScreen extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const RiwayatScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  bool _isPickingFile = false;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      print('File name: ${file.name}');
      print('File path: ${file.path}');
      // Lakukan sesuatu dengan file yang dipilih
    } else {
      // Pengguna membatalkan pemilihan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari Transaksi ...',
            prefixIcon: Icon(Icons.search, color: Color(0xFF198754)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<HistoryTransactionProvider>(
        builder: (context, state, _) {
          final authWatch = context.watch<AuthProvider>();
          if (authWatch.isLoggedIn) {
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
                return EmptyShop(
                  onTapped: widget.onTapped,
                );
              case ResultState.error:
                return ErrorRefresh(
                  onPressed: () async {
                    await state.getTransactions();
                  },
                );
              case ResultState.loaded:
                if (state.transactions?.isEmpty ?? true) {
                  return EmptyShop(
                    onTapped: widget.onTapped,
                  );
                } else {
                  return listTransactions(state);
                }
            }
          } else {
            return UnauthorizedPage(
              onTapped: widget.onTapped,
            );
          }
        },
      ),
    );
  }

  Container listTransactions(HistoryTransactionProvider state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
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
                            onTap: () { 
                          widget.onTapped(AppPage.detailHistory);
                        },
                            child: 
                        Container(
                          child: InkWell(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Color(0xFF198754),
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Belanja',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Tanggal',
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Status Transaksi',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.3,
                                ),
                                SizedBox(height: 5),
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
                                        )
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
                                    ElevatedButton(
                                      onPressed: () {
                                        widget.onTapped(AppPage.detailHistory);
                                      },
                                      child: Text('Upload Bukti Transaksi'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF198754),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
