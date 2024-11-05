import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Container(
                margin: const EdgeInsets.only(bottom: 24.0),
                child: Image.network(
                  'https://simkhm.id/wonorejo/admin/dist/assets/img/khm.png', // Ganti dengan URL logo Anda
                  height: 80,
                ),
              ),

              // Card untuk Form Login
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
                          'Login Pasien',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Cek Apakah Anda Sudah Pernah Berobat di KHM',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Label NIK
                      Text(
                        'NIK',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Input NIK
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Masukan NIK',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Tombol Register dan Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Aksi untuk Register
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700], // Warna hijau
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text('Register'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Aksi untuk Login
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text('Login'),
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
  }
}
