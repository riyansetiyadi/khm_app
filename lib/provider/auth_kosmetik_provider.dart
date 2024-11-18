import 'package:flutter/material.dart';
import 'package:khm_app/db/auth_kosmetik_repository.dart';
import 'package:khm_app/models/profile_model.dart';
import 'package:khm_app/models/response_model.dart';
import 'package:khm_app/service/api_kosmetik_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class AuthKosmetikProvider extends ChangeNotifier {
  final AuthKosmetikRepository authRepository;
  final ApiKosmetikService apiService;

  AuthKosmetikProvider(this.authRepository, this.apiService) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  bool isLoggedIn = false;
  String? message;
  ProfileModel? profile;
  ResponseApiModel? response;

  _init() async {
    profile = await authRepository.getProfileKosmetik();
    if (profile != null) isLoggedIn = true;
  }

  Future<bool> login(email, password) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      profile = await authRepository.getProfileKosmetik();
      if (profile == null) {
        ProfileModel result = await apiService.loginApi(email, password);
        message = 'Berhasil masuk';
        if (result.token?.isNotEmpty ?? false) {
          await authRepository.saveProfileKosmetik(result);
          profile = result;
        }
      }
      isLoggedIn = await authRepository.isLoggedInKosmetik();
      _resultState = ResultState.loaded;
      notifyListeners();

      return isLoggedIn;
    } catch (e) {
      message = 'Login gagal!';
      _resultState = ResultState.error;
      return false;
    }
  }

  Future<bool> logout() async {
    _resultState = ResultState.loading;
    notifyListeners();

    await authRepository.deleteProfileKosmetik();
    isLoggedIn = await authRepository.isLoggedInKosmetik();

    _resultState = ResultState.loaded;
    notifyListeners();

    return !isLoggedIn;
  }

  Future<bool> register(
      String fullname,
      String phoneNumber,
      String email,
      String password,
      String datebirth,
      String monthbirth,
      String yearbirth) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      var data = {
        'nama_lengkap': fullname,
        'nohp': phoneNumber,
        'email': email,
        'password': password,
        'tanggal': datebirth,
        'bulan': monthbirth,
        'tahun': yearbirth,
        'registerAwal': ''
      };
      var result = await apiService.registerFirstApi(data);

      _resultState = ResultState.loaded;
      message = result?['status'] ?? "Gagal Daftar";
      notifyListeners();

      return true;
    } catch (e) {
      message = 'Daftar gagal!';
      _resultState = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerConsultation(
    String gender,
    String idNumber,
  ) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getTokenKosmetik();
      final responseResult = await apiService.registerConsultationApi(
        gender,
        idNumber,
        token.toString(),
      );
      response = ResponseApiModel.fromJson(responseResult);

      if (!(response?.error ?? true)) {
        profile = ProfileModel.fromApiJson(
          responseResult,
          token: profile?.token,
        );
        if (profile != null) authRepository.saveProfileKosmetik(profile!);
        message = response?.message ?? 'Berhasil menandaftar';
        _resultState = ResultState.loaded;
        notifyListeners();

        return authRepository.isConsultationDataComplete();
      } else {
        message = response?.message ?? 'Gagal daftar!';
        _resultState = ResultState.error;
        notifyListeners();

        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      message = response?.message ?? 'Gagal daftar!';
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerShop(
    String province,
    String district,
    String subdistrict,
    String village,
    String postalCode,
    String address,
  ) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getTokenKosmetik();
      final responseResult = await apiService.registerShopApi(
        province,
        district,
        subdistrict,
        village,
        postalCode,
        address,
        token.toString(),
      );
      response = ResponseApiModel.fromJson(responseResult);

      if (!(response?.error ?? true)) {
        profile = ProfileModel.fromApiJson(
          responseResult,
          token: profile?.token,
        );

        if (profile != null) authRepository.saveProfileKosmetik(profile!);
        message = response?.message ?? 'Berhasil menandaftar';
        _resultState = ResultState.loaded;
        notifyListeners();

        return authRepository.isChekoutDataComplete();
      } else {
        message = response?.message ?? 'Gagal daftar!';
        _resultState = ResultState.error;
        notifyListeners();

        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      message = response?.message ?? 'Gagal daftar!';
      notifyListeners();
      return false;
    }
  }
}
