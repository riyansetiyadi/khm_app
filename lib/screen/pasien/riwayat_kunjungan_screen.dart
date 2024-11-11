import 'package:flutter/material.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';

class RiwayatKunjunganScreen extends StatefulWidget {
  const RiwayatKunjunganScreen({super.key});

  @override
  State<RiwayatKunjunganScreen> createState() => _RiwayatKunjunganScreenState();
}

class _RiwayatKunjunganScreenState extends State<RiwayatKunjunganScreen> {
  int _rowsPerPage = 10; // Page size
  String _searchQuery = '';
  int _currentPage = 1;

  List<Map<String, String>> data = [
    {"Jadwal": "2024-10-10 07:51:00", "Antrian": "p015"},
  ];

  List<Map<String, String>> get _filteredData {
    return data.where((row) => row["Jadwal"]!.contains(_searchQuery)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayedData = _filteredData
        .skip((_currentPage - 1) * _rowsPerPage)
        .take(_rowsPerPage)
        .toList();

    return MaterialApp(
      home: Scaffold(
        appBar: MainAppBar(
          title: 'SIMKHM',
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Riwayat Registrasi',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data Registrasi',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 4, 61, 108)),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton<int>(
                                  value: _rowsPerPage,
                                  onChanged: (value) {
                                    setState(() {
                                      _rowsPerPage = value ?? 10;
                                      _currentPage = 1; // Reset to first page
                                    });
                                  },
                                  items: [10, 25, 50, 100]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text("Show $e entries"),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Search:"),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _searchQuery = value;
                                        _currentPage = 1; // Reset to first page
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  DataTable(
                                    columns: [
                                      DataColumn(label: Text("Jadwal")),
                                      DataColumn(label: Text("Antrian")),
                                      DataColumn(label: Text("Actions")),
                                    ],
                                    rows: displayedData.map(
                                      (row) {
                                        return DataRow(cells: [
                                          DataCell(Text(row["Jadwal"] ?? "")),
                                          DataCell(Text(row["Antrian"] ?? "")),
                                          DataCell(Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                },
                                                child: Text(
                                                  "Detail",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 9, 74, 11),
                                                  minimumSize: Size(50, 30),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              ElevatedButton(
                                                onPressed: () {
                                                },
                                                child: Text(
                                                  "Batal",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  minimumSize: Size(50, 30),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                        ]);
                                      },
                                    ).toList(),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Showing ${(_currentPage - 1) * _rowsPerPage + 1} to ${(_currentPage - 1) * _rowsPerPage + displayedData.length} of ${_filteredData.length} entries", style: TextStyle(fontSize: 15)),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: _currentPage > 1
                                                ? () {
                                                    setState(() {
                                                      _currentPage--;
                                                    });
                                                  }
                                                : null,
                                            child: Text("Previous", style: TextStyle(fontSize: 15),),
                                          ),
                                          Text("$_currentPage"),
                                          TextButton(
                                            onPressed:
                                                _currentPage * _rowsPerPage <
                                                        _filteredData.length
                                                    ? () {
                                                        setState(() {
                                                          _currentPage++;
                                                        });
                                                      }
                                                    : null,
                                            child: Text("Next", style: TextStyle(fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
  }
}
