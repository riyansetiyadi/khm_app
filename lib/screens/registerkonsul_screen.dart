import 'package:flutter/material.dart';
import 'package:khm_app/models/gender_model.dart';
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
      appBar: AppBar(
        title: Text("Lengkapi Data Diri"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: listGender
                        .map((gender) => _buildGenderOption(gender))
                        .toList()
                    // _buildGenderOption('Man', Icons.male),
                    // SizedBox(width: 8),
                    // _buildGenderOption('Woman', Icons.female),
                    ,
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
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _nikController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'NIK',
                      labelStyle: TextStyle(fontSize: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await authRead.registerConsultation(
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
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('Simpan'),
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
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(GenderModel gender) {
    bool isSelected = _selectedGender == gender.id;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = gender.id;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            border: Border.all(color: isSelected ? Colors.black : Colors.grey),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(gender.icon, color: isSelected ? Colors.black : Colors.grey),
              SizedBox(width: 8),
              Text(
                gender.name,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
