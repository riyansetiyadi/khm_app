import 'package:flutter/material.dart';
import 'package:khm_app/models/province_district_model.dart';
import 'package:khm_app/models/subdistrict_model.dart';
import 'package:khm_app/provider/address_provider.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:provider/provider.dart';

class RegisterAddress extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const RegisterAddress({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  _RegisterAddressState createState() => _RegisterAddressState();
}

class _RegisterAddressState extends State<RegisterAddress> {
  @override
  void initState() {
    super.initState();

    final addressProvider = context.read<AddressProvider>();

    Future.microtask(() async {
      addressProvider.getProvince();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fullnameController.dispose();
    _phoneNumberController.dispose();
    _postalCodeController.dispose();
    _alamatController.dispose();
  }

  final _fullnameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _alamatController = TextEditingController();

  ProvinceDistrictModel? selectedProvince;
  ProvinceDistrictModel? selectedDistrict;
  String? selectedSubdistrict;
  SubdistrictModel? selectedVillage;

  @override
  Widget build(BuildContext context) {
    final authRead = context.read<AuthProvider>();
    _fullnameController.text = authRead.profile?.fullname ?? '';
    _phoneNumberController.text = authRead.profile?.phoneNumber ?? '';
    _postalCodeController.text = authRead.profile?.postalCode ?? '';
    _alamatController.text = authRead.profile?.address ?? '';

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
                          'Data Diri',
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
                              'Nama Lengkap',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          minLines: 1,
                          maxLines: null,
                          controller: _fullnameController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12),
                            hintText: 'Nama Lengkap',
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
                              'Nomor Telepon',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          minLines: 1,
                          maxLines: null,
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12),
                            hintText: 'Nomor Telepon',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 12.0),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Alamat',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Consumer<AddressProvider>(
                                builder: (context, state, _) {
                              print(state.provinces);
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Provinsi',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child:
                                          DropdownButton<ProvinceDistrictModel>(
                                        value: selectedProvince,
                                        hint: Text('Pilih'),
                                        isExpanded: true,
                                        items: state.provinces.map<
                                                DropdownMenuItem<
                                                    ProvinceDistrictModel>>(
                                            (ProvinceDistrictModel province) {
                                          return DropdownMenuItem<
                                              ProvinceDistrictModel>(
                                            value: province,
                                            child: Text(
                                              province.name,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (ProvinceDistrictModel?
                                            newProvince) {
                                          if (newProvince != null) {
                                            state.getDistrict(newProvince.id);
                                            setState(() {
                                              selectedProvince = newProvince;
                                              selectedDistrict = null;
                                              selectedSubdistrict = null;
                                              selectedVillage = null;
                                            });
                                          } else {
                                            final snackBar = SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                "Gagal mendapatkan data propinsi ${newProvince?.name ?? ''}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                              duration:
                                                  const Duration(seconds: 3),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(width: 15),
                            Consumer<AddressProvider>(
                                builder: (context, state, _) {
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kabupaten/Kota',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child:
                                          DropdownButton<ProvinceDistrictModel>(
                                        value: selectedDistrict,
                                        hint: Text('Pilih'),
                                        isExpanded: true,
                                        items: state.districts.map<
                                                DropdownMenuItem<
                                                    ProvinceDistrictModel>>(
                                            (ProvinceDistrictModel district) {
                                          return DropdownMenuItem<
                                              ProvinceDistrictModel>(
                                            value: district,
                                            child: Text(
                                              district.name,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (ProvinceDistrictModel?
                                            newDistrict) {
                                          if (newDistrict != null) {
                                            state
                                                .getSubdistrict(newDistrict.id);
                                            setState(() {
                                              selectedDistrict = newDistrict;
                                              selectedSubdistrict = null;
                                              selectedVillage = null;
                                            });
                                          } else {
                                            final snackBar = SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                "Gagal mendapatkan data kecamatan/kota ${newDistrict?.name ?? ''}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                              duration:
                                                  const Duration(seconds: 3),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Consumer<AddressProvider>(
                                builder: (context, state, _) {
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kecamatan',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: DropdownButton<String>(
                                        value: selectedSubdistrict,
                                        hint: Text('Pilih'),
                                        isExpanded: true,
                                        items: state.subdistrictsUnique
                                            .map<DropdownMenuItem<String>>(
                                                (String subdistrict) {
                                          return DropdownMenuItem<String>(
                                            value: subdistrict,
                                            child: Text(
                                              subdistrict,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newSubdistrict) {
                                          if (newSubdistrict != null) {
                                            state.getVillage(newSubdistrict);
                                            setState(() {
                                              selectedSubdistrict =
                                                  newSubdistrict;
                                              selectedVillage = null;
                                            });
                                          } else {
                                            final snackBar = SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                "Gagal mendapatkan data kecamatan ${newSubdistrict ?? ''}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                              duration:
                                                  const Duration(seconds: 3),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(width: 15),
                            Consumer<AddressProvider>(
                                builder: (context, state, _) {
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Desa/Kelurahan',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: DropdownButton<SubdistrictModel>(
                                        value: selectedVillage,
                                        hint: Text('Pilih'),
                                        isExpanded: true,
                                        items: state.villages.map<
                                                DropdownMenuItem<
                                                    SubdistrictModel>>(
                                            (SubdistrictModel village) {
                                          return DropdownMenuItem<
                                              SubdistrictModel>(
                                            value: village,
                                            child: Text(
                                              village.kelurahan,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged:
                                            (SubdistrictModel? newVillage) {
                                          if (newVillage != null) {
                                            setState(() {
                                              selectedVillage = newVillage;
                                            });
                                          } else {
                                            final snackBar = SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                "Gagal mendapatkan data kelurahan ${newVillage ?? ''}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                              duration:
                                                  const Duration(seconds: 3),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              'Kode Pos',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          minLines: 1,
                          maxLines: null,
                          controller: TextEditingController(
                            text: selectedVillage?.kodepos,
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12),
                            hintText: 'Kode Pos',
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
                              'Alamat Rumah (Dusun, RT, RW)',
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
                            hintText: 'Masukkan Alamat',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 12.0),
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () async {
                            if ((selectedProvince?.name != null) &&
                                (selectedDistrict?.name != null) &&
                                (selectedSubdistrict != null) &&
                                (selectedVillage?.kelurahan != null) &&
                                (selectedVillage?.kodepos != null) &&
                                (_alamatController.text.isNotEmpty)) {
                              final authRead = context.read<AuthProvider>();
                              bool result = await authRead.registerShop(
                                selectedProvince!.name,
                                selectedDistrict!.name,
                                selectedSubdistrict!,
                                selectedVillage!.kelurahan,
                                selectedVillage!.kodepos,
                                _alamatController.text,
                              );

                              if (result) widget.onTapped(AppPage.checkout);
                            }
                          },
                          child: Text('Simpan Alamat'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36),
                            backgroundColor: Color(0xFF198754),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36),
                            backgroundColor: Colors.red,
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
