import 'package:flutter/material.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/list_gender.dart';
import 'package:provider/provider.dart';

class RegisterKonsulScreen extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const RegisterKonsulScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  _RegisterKonsulScreenState createState() => _RegisterKonsulScreenState();
}

class _RegisterKonsulScreenState extends State<RegisterKonsulScreen> {
  final TextEditingController _nikController = TextEditingController();

  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final authRead = context.read<AuthProvider>();

    if (listGender.any((gender) => gender.id == authRead.profile?.gender))
      _selectedGender = authRead.profile?.gender;
    _nikController.text = authRead.profile?.idNumber ?? '';

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
                          'Lengkapi Data Diri',
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
                              'Jenis Kelamin',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedGender,
                            hint: Text('Pilih', style: TextStyle(fontSize: 12)),
                            items: listGender
                                .map(
                                  (gender) => DropdownMenuItem<String>(
                                    value: gender.id,
                                    child: Text(gender.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              'NIK',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _nikController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'NIK',
                            labelStyle: TextStyle(fontSize: 12),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 12.0),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                            ElevatedButton(
                              onPressed: () async {
                                bool result =
                                    await authRead.registerConsultation(
                                  _selectedGender ?? '',
                                  _nikController.text,
                                );
                                if (result) {
                                  widget.onTapped(AppPage.addroom);
                                } else {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      authRead.message ?? 'Gagal mendaftar!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    duration: const Duration(seconds: 3),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text('Simpan'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF198754),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
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
