import 'package:flutter/material.dart';
import 'package:infopediaflutter/api/sp.dart';
import 'package:infopediaflutter/models/article.dart';
import 'package:infopediaflutter/pages/article_detail_view.dart';

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
  final List<Article> articles = [
    Article(
      title: 'Sample News Title 1',
      imageUrl: 'https://picsum.photos/300/200',
    ),
    Article(
      title: 'Sample News Title 2',
      imageUrl: 'https://picsum.photos/300/200',
    ),
    Article(
      title: 'Sample News Title 3',
      imageUrl: 'https://picsum.photos/300/200',
    ),
    Article(
      title: 'Sample News Title 4',
      imageUrl: 'https://picsum.photos/300/200',
    ),
    Article(
      title: 'Sample News Title 5',
      imageUrl: 'https://picsum.photos/300/200',
    ),
  ];

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
        actions: [
          IconButton(
            onPressed: () {
              setToken("");
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          Article article = articles[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(article: article),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  Image.network(
                    article.imageUrl,
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
      ),
    );
  }
}
