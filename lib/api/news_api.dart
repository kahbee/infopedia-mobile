import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/base_api.dart';

class NewsAPI extends BaseAPI {
  Future<List<News>> fetchNews() async {
    final response = await http.get(
      Uri.parse('${super.baseUrl}/news'), 
      headers: super.headersWithToken(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        List<dynamic> data = jsonResponse['data'];
        return data.map((news) => News.fromJson(news)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } else {
      throw Exception('Failed to connect to the API');
    }
  }
}