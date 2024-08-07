import 'dart:convert';

import 'package:khm_app/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String profileKey = "profile";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    final state = preferences.getString(profileKey);
    print(state);
    print(state == null);
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
      profile = ProfileModel.fromJson(json.decode(jsonString));
    } catch (e) {
      profile = null;
    }
    return profile;
  }
}
