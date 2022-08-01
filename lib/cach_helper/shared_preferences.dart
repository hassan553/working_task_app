import 'package:shared_preferences/shared_preferences.dart';

class CatchHelper {
  static dynamic sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static  setData({
    dynamic value,
    dynamic key,
  }) {
    sharedPreferences.setString(key, value);
  }

  static getData({
    dynamic key,
  }) {
    return sharedPreferences.getString(key)??'';
  }
}
