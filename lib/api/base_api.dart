import 'package:shared_preferences/shared_preferences.dart';

class BaseAPI {
  String baseUrl = "http://192.168.1.6:3000/api";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Map<String, String> headersWithToken() {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $getToken()"
    };
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
