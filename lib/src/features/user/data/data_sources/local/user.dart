import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  final SharedPreferences _preferences;

  UserSharedPrefs(this._preferences);

  /// __________ Clear Storage __________ ///
  Future<bool> clearAllLocalData() async {
    return true;
  }

  Future<void> saveLoginToken(String token) async {
    await _preferences.setString('loginToken', token);
  }

  Future<String?> getLoginToken() async {
    return _preferences.getString('loginToken');
  }
}
