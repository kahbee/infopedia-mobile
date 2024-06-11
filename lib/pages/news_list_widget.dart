import 'package:flutter/material.dart';
import 'package:infopediaflutter/api/base_api.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/pages/article_detail_view.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({
    super.key,
    required this.futureNews,
  });

  final Future<List<News>> futureNews;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
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
                      Image.network(
                        "${BaseAPI.url}storage/${news.image}",
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
    );
  }
}
