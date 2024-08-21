import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/models/province_district_model.dart';
import 'package:khm_app/models/subdistrict_model.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class AddressProvider extends ChangeNotifier {
  final ApiService apiService;

  AddressProvider(this.apiService) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  String? message;
  List<ProvinceDistrictModel> provinces = [];
  List<ProvinceDistrictModel> districts = [];
  List<SubdistrictModel> subdistrictsComplete = [];
  List<String> subdistrictsUnique = [];
  List<SubdistrictModel> villages = [];

  _init() async {}

  Future<bool> getProvinces() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      final responseResult = await apiService.getIndonesiaProvince();
      provinces = parseProvincesDistricts(responseResult);
      message = 'Berhasil mendapatkan provinsi';
      _resultState = ResultState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan provinsi';
      notifyListeners();
      return false;
    }
  }

  Future<ProvinceDistrictModel?> getProvinceByName(String? provinceName) async {
    try {
      if (provinces.isEmpty) await getProvinces();
      return provinces.firstWhere((province) => province.name == provinceName);
    } catch (e) {
      return null;
    }
  }

  Future<ProvinceDistrictModel?> getDistrictByName(String? districtName) async {
    try {
      return districts.firstWhere((district) => district.name == districtName);
    } catch (e) {
      return null;
    }
  }

  Future<SubdistrictModel?> getVillageByName(String? villageName) async {
    try {
      return villages.firstWhere((village) => village.kelurahan == villageName);
    } catch (e) {
      return null;
    }
  }

  Future<bool> getDistrict(String idProvince) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      final responseResult = await apiService.getIndonesiaDistrict(idProvince);
      districts = parseProvincesDistricts(responseResult);
      message = 'Berhasil mendapatkan kabupaten/kota';
      _resultState = ResultState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan kabupaten/kota';
      notifyListeners();
      return false;
    }
  }

  Future<bool> getSubdistrict(String idDistrict) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      final responseResult =
          await apiService.getIndonesiaSubdistrict(idDistrict);
      subdistrictsComplete = parseSubdistricts(responseResult);
      subdistrictsUnique = subdistrictsComplete
          .map((subdistrict) => subdistrict.kecamatan)
          .toSet()
          .toList();
      print(subdistrictsComplete);
      message = 'Berhasil mendapatkan kecamatan';
      _resultState = ResultState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan kecamatan';
      notifyListeners();
      return false;
    }
  }

  Future<bool> getVillage(String nameSubdistrict) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      villages = subdistrictsComplete
          .where((subdistrict) => subdistrict.kecamatan == nameSubdistrict)
          .toList();
      message = 'Berhasil mendapatkan desa/kelurahan';
      _resultState = ResultState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _resultState = ResultState.error;
      message = 'Gagal mendapatkan desa/kelurahan';
      notifyListeners();
      return false;
    }
  }
}
