import 'package:flutter/material.dart';

class RegisterCheckout extends StatefulWidget {
  @override
  _RegisterCheckoutState createState() => _RegisterCheckoutState();
}

class _RegisterCheckoutState extends State<RegisterCheckout> {
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController(text: 'Provinsi , Kabupaten/Kota , Kecamatan , Desa/Kelurahan , , 0 ');
  final _noHPController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/login.png',
                height: 70,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Container(
                width: 400,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Silahkan Isi Data',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              'Nama Lengkap Tujuan',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 12.0),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              'Alamat Lengkap Tujuan',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          minLines: 1,
                          maxLines: null,
                          controller: _alamatController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 12.0),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              'Nomor HP Tujuan',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _noHPController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 12.0),
                          ),
                        ),                       
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Lengkapi Data Diri'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36),
                            backgroundColor: Color(0xFF198754),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
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
    );
  }
}
