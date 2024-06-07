import 'package:infopediaflutter/api/sp.dart';

class BaseAPI {
  static String url = "http://192.168.1.3:8000/";
  String baseUrl = "${url}api";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Map<String, String> headersWithToken() {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $getToken()"
    };
  }
}
