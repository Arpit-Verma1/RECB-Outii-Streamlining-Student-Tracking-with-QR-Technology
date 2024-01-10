import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const key = 'User_id';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setusername(String isChecked1) async =>
      await _preferences.setString(key, isChecked1);
  static String? getusername() => _preferences.getString(key);
  static Future clear() => _preferences.clear();
}
