import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:infopediaflutter/api/base_api.dart';
import 'package:infopediaflutter/pages/article_detail_view.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/news_api.dart';

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
  const NewsHomePage({super.key});

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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("infopedia", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: FutureBuilder<List<News>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                News news = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailPage(news: news),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImageWithRetry(
                              "${BaseAPI.url}storage/${news.image}"),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Text(news.title)
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
