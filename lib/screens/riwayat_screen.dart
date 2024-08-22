import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khm_app/extension/capitalize.dart';
import 'package:khm_app/extension/currency.dart';
import 'package:khm_app/extension/status_formatted.dart';
import 'package:khm_app/models/group_transaction_model.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/transaction_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
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
      body: Consumer<TransactionProvider>(
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

  Container listTransactions(TransactionProvider state) {
    List<GroupedTransaction> transactions = state.groupedTransactions!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            GroupedTransaction transaction = transactions[index];
            return Card(
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
                      onTap: () async {
                        bool result = await state
                            .getTransactionByNota(transaction.codeNota);
                        if (result) {
                          widget.onTapped(AppPage.detailHistory);
                        } else {}
                      },
                      child: Container(
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
                                            DateFormat('d MMM y', 'id_ID')
                                                .format(transaction.createdAt),
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      transaction.status.statusFormatted(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5.0),
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
                                        transaction.products[0].produk,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "${transaction.products[0].jumlah} barang",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              if (transaction.products.length > 1)
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  width: double.infinity,
                                  child: Text(
                                    "+${transaction.products.length - 1} produk lainnya",
                                    textAlign: TextAlign.start,
                                  ),
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
                                        transaction.totalHarga.toRupiah(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  if (state
                                          .transaction!.first.buktiPembayaran ==
                                      null)
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
            );
          }),
    );
  }
}
