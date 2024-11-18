import 'dart:convert';

import 'package:khm_app/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthKosmetikRepository {
  final String profileKey = "profile-kosmetik";

  Future<bool> isLoggedInKosmetik() async {
    final preferences = await SharedPreferences.getInstance();
    final state = preferences.getString(profileKey);
    if (state == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isConsultationDataComplete() async {
    ProfileModel? profile = await getProfileKosmetik();
    List<bool> result = [
      profile?.gender?.isEmpty ?? false,
      profile?.idNumber?.isEmpty ?? false
    ];
    return result.every((res) => !res);
  }

  Future<bool> isChekoutDataComplete() async {
    ProfileModel? profile = await getProfileKosmetik();
    List<bool> result = [
      profile?.fullname?.isEmpty ?? false,
      profile?.phoneNumber?.isEmpty ?? false,
      profile?.district?.isEmpty ?? false,
      profile?.subdistrict?.isEmpty ?? false,
      profile?.village?.isEmpty ?? false,
      profile?.postalCode?.isEmpty ?? false,
      profile?.address?.isEmpty ?? false,
    ];
    return result.every((res) => !res);
  }

  Future<bool> saveProfileKosmetik(ProfileModel profile) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(profileKey, jsonEncode(profile.toJson()));
  }

  Future<bool> deleteProfileKosmetik() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.remove(profileKey);
  }

  Future<ProfileModel?> getProfileKosmetik() async {
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

  Future<String?> getTokenKosmetik() async {
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
