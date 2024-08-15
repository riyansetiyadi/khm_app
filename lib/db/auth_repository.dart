import 'dart:convert';

import 'package:khm_app/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String profileKey = "profile";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    final state = preferences.getString(profileKey);
    if (state == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> saveProfile(ProfileModel profile) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(profileKey, jsonEncode(profile.toJson()));
  }

  Future<bool> deleteProfile() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.remove(profileKey);
  }

  Future<ProfileModel?> getProfile() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(profileKey) ?? "";
    ProfileModel? profile;
    try {
      profile = ProfileModel.fromLocalJson(json.decode(jsonString));
    } catch (e) {
      profile = null;
    }
    return profile;
  }

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(profileKey) ?? "";
    String? token = null;
    ProfileModel? profile;
    try {
      profile = ProfileModel.fromLocalJson(json.decode(jsonString));
      token = profile.token;
    } catch (e) {
      token = null;
    }
    return token;
  }
}
