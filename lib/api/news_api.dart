import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infopediaflutter/api/article_response.dart';
import 'package:infopediaflutter/api/base_response.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/base_api.dart';

class NewsAPI extends BaseAPI {
  Future<List<News>> fetchNews() async {
    final res = await http.get(
      Uri.parse('${super.baseUrl}/news'),
      headers: super.headersWithToken(),
    );
    var body = jsonDecode(res.body);

    var parsed = BaseResponse.fromJson(body);
    if (res.statusCode == 200 && parsed.success) {
      List<dynamic> data = parsed.data;
      return data.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<ArticleResponse> fetchNewsBySlug(String slug) async {
    final res = await http.get(
      Uri.parse('${super.baseUrl}/news/$slug'),
      headers: super.headersWithToken(),
    );
    var body = jsonDecode(res.body);

    var parsed = BaseResponse.fromJson(body);
    if (res.statusCode == 200 && parsed.success) {
      var data = ArticleResponse.fromJson(parsed.data);
      return data;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
