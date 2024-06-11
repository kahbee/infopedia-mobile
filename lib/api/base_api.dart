import 'package:infopediaflutter/api/sp.dart';

class BaseAPI {
  static String url = "http://192.168.1.3:8000/";
  String baseUrl = "${url}api";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };

  Future<Map<String, String>> headersWithToken() async {
    var token = await getToken();
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }
}
