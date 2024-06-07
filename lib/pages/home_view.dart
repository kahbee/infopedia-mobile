import 'package:flutter/material.dart';
import 'package:infopediaflutter/api/base_api.dart';
// import 'package:infopediaflutter/models/article.dart';
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
  // final List<Article> articles = [
  //   Article(
  //     title: 'Sample News Title 1',
  //     imageUrl: 'https://picsum.photos/300/200',
  //   ),
  //   Article(
  //     title: 'Sample News Title 2',
  //     imageUrl: 'https://picsum.photos/300/200',
  //   ),
  //   Article(
  //     title: 'Sample News Title 3',
  //     imageUrl: 'https://picsum.photos/300/200',
  //   ),
  //   Article(
  //     title: 'Sample News Title 4',
  //     imageUrl: 'https://picsum.photos/300/200',
  //   ),
  //   Article(
  //     title: 'Sample News Title 5',
  //     imageUrl: 'https://picsum.photos/300/200',
  //   ),
  // ];
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
                News article = snapshot.data![index];
                return InkWell(
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ArticleDetailPage(article: article),
                  //     ),
                  //   );
                  // },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          BaseAPI.url + "storage/" + article.image,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Text(article.title)
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
