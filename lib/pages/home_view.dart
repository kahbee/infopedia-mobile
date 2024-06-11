import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:infopediaflutter/api/base_api.dart';
import 'package:infopediaflutter/pages/article_detail_view.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/news_api.dart';
import 'package:infopediaflutter/pages/search_view.dart';
import '../api/sp.dart';
import 'news_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsAPI().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("infopedia", style: TextStyle(color: Colors.black)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchView(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    setToken("");
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/login");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: NewsListWidget(futureNews: futureNews),
    );
  }
}
