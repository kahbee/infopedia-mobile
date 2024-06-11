import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infopediaflutter/api/article_response.dart';
import 'package:infopediaflutter/api/base_response.dart';
import 'package:infopediaflutter/models/article.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/base_api.dart';

class NewsAPI extends BaseAPI {
  Future<List<News>> fetchNews() async {
    final res = await http.get(
      Uri.parse('${super.baseUrl}/news'),
      headers: await super.headersWithToken(),
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
      headers: await super.headersWithToken(),
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

  Future<bool> bookmarkNews(String slug) async {
    final res = await http.post(
      Uri.parse('${super.baseUrl}/news/$slug/bookmark'),
      headers: await super.headersWithToken(),
    );
    var body = jsonDecode(res.body);

    var parsed = BaseResponse.fromJson(body);
    if (res.statusCode == 200 && parsed.success) {
      return true;
    } else {
      throw Exception('Failed to bookmark news');
    }
  }

  Future<bool> unbookmarkNews(String slug) async {
    final res = await http.delete(
      Uri.parse('${super.baseUrl}/news/$slug/bookmark'),
      headers: await super.headersWithToken(),
    );
    var body = jsonDecode(res.body);

    var parsed = BaseResponse.fromJson(body);
    if (res.statusCode == 200 && parsed.success) {
      return true;
    } else {
      throw Exception('Failed to unbookmark news');
    }
  }

  Future<bool> addComment(int id, String content) async {
    final res = await http.post(
      Uri.parse('${super.baseUrl}/comments'),
      headers: await super.headersWithToken(),
      body: jsonEncode({'content': content, 'news_id': id}),
    );
    var body = jsonDecode(res.body);

    var parsed = BaseResponse.fromJson(body);
    if (res.statusCode == 200 && parsed.success) {
      return true;
    } else {
      throw Exception('Failed to add comment');
    }
  }

  Future<List<News>> searchNews(String query) async {
    final res = await http.get(
      Uri.parse('${super.baseUrl}/search').replace(queryParameters: {
        'query': query,
      }),
      headers: await super.headersWithToken(),
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

  Future<List<News>> fetchBookmarkedNews() async {
    final res = await http.get(
      Uri.parse('${super.baseUrl}/bookmark'),
      headers: await super.headersWithToken(),
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
}
