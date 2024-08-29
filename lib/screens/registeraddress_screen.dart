import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/models/province_district_model.dart';
import 'package:khm_app/models/subdistrict_model.dart';
import 'package:khm_app/provider/address_provider.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterAddress extends StatefulWidget {
  const RegisterAddress({
    Key? key,
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
      await addressProvider.getProvinces();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setAddressUser();
    });
  }

  @override
  void dispose() {
    _postalCodeController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  final _postalCodeController = TextEditingController();
  final _alamatController = TextEditingController();

  ProvinceDistrictModel? selectedProvince;
  ProvinceDistrictModel? selectedDistrict;
  String? selectedSubdistrict;
  SubdistrictModel? selectedVillage;

  Future<void> _setAddressUser() async {
    final addressProvider = context.read<AddressProvider>();
    final authRead = context.read<AuthProvider>();

    ProvinceDistrictModel? userProvince =
        await addressProvider.getProvinceByName(authRead.profile?.province);
    if (userProvince != null)
      await addressProvider.getDistrict(userProvince.id);
    ProvinceDistrictModel? userDistrict =
        await addressProvider.getDistrictByName(authRead.profile?.district);
    if (userDistrict != null)
      await addressProvider.getSubdistrict(userDistrict.id);
    String? userSubdistrict = authRead.profile?.subdistrict;
    if (userSubdistrict != null)
      await addressProvider.getVillage(userSubdistrict);
    SubdistrictModel? userVillage =
        await addressProvider.getVillageByName(authRead.profile?.village);
    if (mounted) {
      setState(() {
        selectedProvince = userProvince;
        selectedDistrict = userDistrict;
        selectedSubdistrict = userSubdistrict;
        selectedVillage = userVillage;
      });

      _postalCodeController.text = authRead.profile?.postalCode ?? '';
      _alamatController.text = authRead.profile?.address ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atur Alamat Pengiriman"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Consumer<AddressProvider>(
                                builder: (context, state, _) {
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
                                                "Gagal mendapatkan data provinsi ${newProvince?.name ?? ''}",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Desa/Kelurahan',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
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
                              },
                            ),
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
                              horizontal: 5.0,
                              vertical: 12.0,
                            ),
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
                              horizontal: 5.0,
                              vertical: 12.0,
                            ),
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

                              if (result) context.pushReplacement('/checkout');
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
