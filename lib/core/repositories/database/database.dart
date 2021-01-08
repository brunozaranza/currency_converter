import 'package:currency_converter/core/models/api_response_from_database.dart';
import 'package:currency_converter/core/utils/date_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static Future<bool> saveData<T>(String key, T data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime date = DateTime.now();

    bool success;

    if (data is String) {
      success = await prefs.setString(key, data);
    } else if (data is int) {
      success = await prefs.setInt(key, data);
    } else if (data is double) {
      success = await prefs.setDouble(key, data);
    } else if (data is bool) {
      success = await prefs.setBool(key, data);
    }

    if (success) {
      prefs.setString("$key.upload", DateUtil.parseDateToString(date));
    }

    return success;
  }

  static Future<ApiResponseFromDatabase> getJson({String fromKey}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String lastUploadDate = await prefs.get("$fromKey.upload");
    String json = await prefs.get(fromKey);

    return ApiResponseFromDatabase(lastUploadDate, json);
  }

  static saveCurrenciesToCompare(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("CTC", list);
  }

  static Future<List<String>> getCurrenciesToCompare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("CTC");
  }
}