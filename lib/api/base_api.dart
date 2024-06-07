import 'package:infopediaflutter/api/sp.dart';

class BaseAPI {
  String baseUrl = "http://192.168.1.6:8000/api";
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
