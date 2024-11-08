import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';

class LoginPasienScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: MainAppBar(
        title: 'SIMKHM',
      ),
      drawer: MainDrawer(),
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
                  height: 70,
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
                              context.push('/register-pasien');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 35, 94, 37), // Warna hijau
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text('Register',
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              context.push('/menu-pasien');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 35, 94, 37),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text('Login',
                                style: TextStyle(color: Colors.white)),
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
