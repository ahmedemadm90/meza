import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedpref;
  static init() async {
    sharedpref = await SharedPreferences.getInstance();
    CacheHelper.putData(key: 'isDark', value: false);
  }

  static Future<bool> putData({key, value}) async {
    return await sharedpref!.setBool(key, value);
  }

  static dynamic getData(key) {
    return sharedpref!.get(key);
  }

  static Future<bool?> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedpref!.setString(key, value);
    if (value is int) return await sharedpref!.setInt(key, value);
    if (value is bool) return await sharedpref!.setBool(key, value);
    if (value is double) return await sharedpref!.setDouble(key, value);
  }

  static Future<bool> removeData({key}) async {
    return await sharedpref!.remove('token');
  }
}
