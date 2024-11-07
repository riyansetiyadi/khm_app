import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Register2Screen extends StatefulWidget {
  const Register2Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Register2Screen> createState() => _Register2ScreenState();
}

class _Register2ScreenState extends State<Register2Screen> {
  String? selectedBPJS; // Variable for gender selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Container(
                margin: const EdgeInsets.only(bottom: 24.0),
                child: Image.network(
                  'https://simkhm.id/wonorejo/admin/dist/assets/img/khm.png',
                  height: 70,
                ),
              ),

              // Card untuk Form Register
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
                          hint: Text('Pilih', style: TextStyle(fontSize: 15, color: Colors.grey)),
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
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/register');
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
                      Text(
                        'Check NIK yang lain?',
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 35, 94, 37),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text('Ajukan Pendaftaran',
                              style: TextStyle(color: Colors.white)),
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
