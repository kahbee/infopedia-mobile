import 'package:flutter/material.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/news_api.dart';
import 'package:infopediaflutter/pages/news_list_widget.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsAPI().fetchBookmarkedNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NewsListWidget(futureNews: futureNews),
      ),
    );
  }
}
