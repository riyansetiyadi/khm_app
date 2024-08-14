import 'package:flutter/material.dart';
import 'package:khm_app/utils/enum_app_page.dart';

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
        title: Text(
              'Riwayat Transaksi',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No.Inv',)),
                    DataColumn(label: Text('Produk',)),
                    DataColumn(label: Text('Total',)),
                    DataColumn(label: Text('Status',)),
                    DataColumn(label: Text('No. Resi',)),
                    DataColumn(label: Text('Aksi',)),
                  ],
                  rows: const [
                    DataRow(
                      cells: const [
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
