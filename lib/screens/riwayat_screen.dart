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
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text('No.Inv', style: TextStyle(fontSize: 15))),
                  DataColumn(
                      label: Text('Produk', style: TextStyle(fontSize: 15))),
                  DataColumn(
                      label: Text('Total', style: TextStyle(fontSize: 15))),
                  DataColumn(
                      label: Text('Status', style: TextStyle(fontSize: 15))),
                  DataColumn(
                      label: Text('No. Resi', style: TextStyle(fontSize: 15))),
                  DataColumn(
                      label: Text('Aksi', style: TextStyle(fontSize: 15))),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(
                        ElevatedButton(
                          onPressed: _pickFile,
                          child: Text('Upload Bukti'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF198754),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
