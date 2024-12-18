import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/provider/auth_kosmetik_provider.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _fullnameController = TextEditingController();
  final _alamatController = TextEditingController(
      text: 'Provinsi , Kabupaten/Kota , Kecamatan , Desa/Kelurahan , , 0 ');
  final _noHPController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authRead = context.read<AuthKosmetikProvider>();
    final cartRead = context.read<CartProvider>();
    _fullnameController.text = authRead.profile?.fullname ?? '';
    _alamatController.text =
        "Provinsi ${authRead.profile?.province ?? ''}, Kabupaten/Kota ${authRead.profile?.district ?? ''}, Kecamatan ${authRead.profile?.subdistrict ?? ''}, Desa/Kelurahan ${authRead.profile?.village ?? ''}, ${authRead.profile?.address ?? ''}, ${authRead.profile?.postalCode ?? ''}";
    _noHPController.text = authRead.profile?.phoneNumber ?? '';
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
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
                          'Pastikan Data Sudah Benar!',
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
                          controller: _fullnameController,
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextField(
                                  minLines: 1,
                                  maxLines: null,
                                  controller: _alamatController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(fontSize: 12),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 12.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () =>
                                    context.push('/register-address-kosmetik'),
                              ),
                            ),
                          ],
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
                        SizedBox(height: 10.0),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (await cartRead.chekoutCart()) {
                                    context.pushReplacement(
                                        '/riwayat-shop-kosmetik');
                                  } else {
                                    print(cartRead.message);
                                  }
                                  ;
                                },
                                child: Text('Checkout'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
