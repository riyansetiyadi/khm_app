import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaftarPasienLamaScreen extends StatefulWidget {
  const DaftarPasienLamaScreen({super.key});

  @override
  State<DaftarPasienLamaScreen> createState() => _DaftarPasienLamaScreenState();
}

class _DaftarPasienLamaScreenState extends State<DaftarPasienLamaScreen> {
  String? selectedRawat;
  String? selectedAntrian;
  String? selectedPembayaran;
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar rawat jalan'),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rawat Jalan',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pendaftaran Online',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Jenis Perawatan',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<String>(
                        value: selectedRawat,
                        hint:
                            Text('Rawat Jalan', style: TextStyle(fontSize: 15)),
                        isExpanded: true,
                        items: <String>['Rawat Jalan'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRawat = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Data Umum',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Masukan Nama Pasien',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5), // Atur ketebalan di sini
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5), // Atur ketebalan di sini
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No RM Pasien',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Masukan Nama Pasien',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5), // Atur ketebalan di sini
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5), // Atur ketebalan di sini
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Jadwal',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller:
                          dateController, //editing controller of this TextField
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5), // Atur ketebalan di sini
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5), // Atur ketebalan di sini
                          ),
                          labelText: "dd/mm/yy" //label text of field
                          ),
                      readOnly: true, // when true user cannot edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          print(
                              formattedDate); //formatted date output using intl package =>  2022-07-04
                          //You can format date as per your need

                          setState(() {
                            dateController.text =
                                formattedDate; //set foratted date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Antrian',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<String>(
                        value: selectedAntrian,
                        hint: Text('Silahkan Pilih Antrian',
                            style: TextStyle(fontSize: 15)),
                        isExpanded: true,
                        items: <String>['Silahkan Pilih Antrian']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAntrian = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Pembayaran',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<String>(
                        value: selectedPembayaran,
                        hint: Text('Silahkan Pilih Pembayaran',
                            style: TextStyle(fontSize: 15)),
                        isExpanded: true,
                        items: <String>['bpjs', 'umum'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPembayaran = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Keluhan',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Keluhan',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5), // Atur ketebalan di sini
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5), // Atur ketebalan di sini
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 35, 94, 37), // Warna hijau
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text('Simpan',
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Aksi untuk Login
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 87, 87, 87),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text('Reset',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
