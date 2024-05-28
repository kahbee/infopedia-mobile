import 'package:flutter/material.dart';
import 'package:infopediaflutter/models/article.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

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
            const SizedBox(height: 20),
            Text(article.title, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
