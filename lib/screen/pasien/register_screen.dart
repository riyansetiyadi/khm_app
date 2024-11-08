import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _yearController = TextEditingController();
  int? selectedDay;
  int? selectedMonth;
  String? selectedGender;
  String? selectedBPJS;
  String? selectedProvinsi;
  String? selectedKota;
  String? selectedKecamatan;
  String? selectedDesa;
  bool showRegistrasi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: MainAppBar(
        title: 'SIMKHM',
      ),
      drawer: MainDrawer(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 24.0),
                child: Image.network(
                  'https://simkhm.id/wonorejo/admin/dist/assets/img/khm.png',
                  height: 70,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Daftar Pasien',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      if (!showRegistrasi) ...[
                        Text(
                          'Nama Lengkap',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Masukan Nama Pasien',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nama Ayah',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Masukan Nama Ayah Pasien',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Tanggal Lahir',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButton<int>(
                                value: selectedDay,
                                hint: Text('Tanggal',
                                    style: TextStyle(fontSize: 15)),
                                items: List.generate(31, (index) {
                                  return DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text('${index + 1}'),
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDay = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButton<int>(
                                value: selectedMonth,
                                hint: Text('Bulan',
                                    style: TextStyle(fontSize: 15)),
                                items: List.generate(12, (index) {
                                  return DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text('${index + 1}'),
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    selectedMonth = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                controller: _yearController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Tahun',
                                  labelStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Jenis Kelamin',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                            value: selectedGender,
                            hint: Text('Pilih Jenis Kelamin',
                                style: TextStyle(fontSize: 15)),
                            isExpanded: true,
                            items: <String>['Laki-laki', 'Perempuan']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showRegistrasi = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 35, 94, 37),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text('Selanjutnya',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ] else ...[
                        Text(
                          'No. HP',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Masukan No. HP Pasien',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nama KTP',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Masukan No. Identitas Pasien',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Apakah Pasien Merupakan Pengguna BPJS?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                            value: selectedBPJS,
                            hint: Text('Pilih',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            isExpanded: true,
                            items: <String>['Ya', 'Tidak'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBPJS = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Provinsi',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                            value: selectedProvinsi,
                            hint: Text('Pilih',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            isExpanded: true,
                            items: <String>['Provinsi'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedProvinsi = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Kota/Kabupaten',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                            value: selectedKota,
                            hint: Text('Pilih',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            isExpanded: true,
                            items: <String>['Kota'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedKota = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Kecamatan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                            value: selectedKecamatan,
                            hint: Text('Pilih',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            isExpanded: true,
                            items: <String>['Kecamatan'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedKecamatan = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Desa',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                            value: selectedDesa,
                            hint: Text('Pilih',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            isExpanded: true,
                            items: <String>['Desa'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDesa = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Kode Pos',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Masukan Kode Pos',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Alamat Rumah (Dusun, RT, RW)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Masukan Alamat',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Alamat Domisili Sekarang',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 2, 128, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text('Samakan dengan Alamat Asal',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Masukan Alamat Domisili Sekarang',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showRegistrasi = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 35, 94, 37),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text('Sebelumnya',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            context.push('/login-pasien');
                          },
                          child: Text(
                            'Check NIK yang lain?',
                            style: TextStyle(color: Colors.blue),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/login-pasien');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 35, 94, 37),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Ajukan Pendaftaran',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
