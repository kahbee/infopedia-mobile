import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:infopediaflutter/api/article_response.dart';
import 'package:infopediaflutter/models/article.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/base_api.dart';
import 'package:infopediaflutter/api/news_api.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ArticleDetailPage extends StatefulWidget {
  final News news;

  const ArticleDetailPage({super.key, required this.news});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late Future<ArticleResponse> futureArticle;
  @override
  void initState() {
    super.initState();
    futureArticle = NewsAPI().fetchNewsBySlug(widget.news.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title),
      ),
      body: Center(
        child: FutureBuilder<ArticleResponse>(
            future: futureArticle,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } 
              else if (!snapshot.hasData) {
                return const Center(child: Text('No news available'));
              } else {
                Article article = snapshot.data!.news;
                // List<Comment> comments = snapshot.data!.comments;
                // bool bookmarked = snapshot.data!.bookmarked;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImageWithRetry(
                          "${BaseAPI.url}storage/${article.image}"),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      article.title,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Published on: ${article.createdAt.toString()}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: HtmlWidget(
                        article.content,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
      ),
    );
  }
}
