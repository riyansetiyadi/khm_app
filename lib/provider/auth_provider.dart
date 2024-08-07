import 'package:flutter/material.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/models/profile_model.dart';
import 'package:khm_app/service/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  AuthProvider(this.authRepository, this.apiService) {
    _init();
  }

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;
  String? message;
  ProfileModel? profile;

  _init() async {
    profile = await authRepository.getProfile();
  }

  Future<bool> login(email, password) async {
    isLoadingLogin = true;
    notifyListeners();

    try {
      profile = await authRepository.getProfile();
      if (profile == null) {
        var result = await apiService.loginApi(email, password);
        message = result["status"];
        if (result["uniq_code"].isNotEmpty) {
          await authRepository
              .saveProfile(ProfileModel(token: result["uniq_code"]));
          profile = ProfileModel(token: result["uniq_code"]);
        }
      }
      isLoggedIn = await authRepository.isLoggedIn();
      isLoadingLogin = false;
      notifyListeners();

      return isLoggedIn;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    await authRepository.deleteProfile();
    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  // Future<bool> register(User user) async {
  //   isLoadingRegister = true;
  //   notifyListeners();

  //   ApiResponseRegisterModel result = await apiService.registerApi(user);

  //   isLoadingRegister = false;
  //   message = result.message;
  //   notifyListeners();

  //   return !result.error;
  // }
}
