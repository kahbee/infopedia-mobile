import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final List<Article> articles = [
    Article(title: 'Sample News Title 1', imageUrl: 'https://via.placeholder.com/100'),
    Article(title: 'Sample News Title 2', imageUrl: 'https://via.placeholder.com/100'),
    Article(title: 'Sample News Title 3', imageUrl: 'https://via.placeholder.com/100'),
    Article(title: 'Sample News Title 4', imageUrl: 'https://via.placeholder.com/100'),
    Article(title: 'Sample News Title 5', imageUrl: 'https://via.placeholder.com/100'),
    // Add more articles as needed
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
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              leading: Image.network(
                article.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              title: Text(article.title),
            ),
          );
        },
      ),
    );
  }
}

class Article {
  final String title;
  final String imageUrl;

  Article({required this.title, required this.imageUrl});
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(article.imageUrl),
            SizedBox(height: 20),
            Text(article.title, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}