import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late Future<List<Comment>> futureComments;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureArticle = NewsAPI().fetchNewsBySlug(widget.news.slug);
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty) {
      await NewsAPI().addComment(widget.news.id, _commentController.text);
      setState(() {
        futureArticle = NewsAPI().fetchNewsBySlug(widget.news.slug);
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<ArticleResponse>(
            future: futureArticle,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No news available'));
              } else {
                Article article = snapshot.data!.news;
                bool bookmarked = snapshot.data!.bookmarked;
                List<Comment> comments = snapshot.data!.comments;

                void handleBookmark() async {
                  if (bookmarked) {
                    await NewsAPI().unbookmarkNews(widget.news.slug);
                  } else {
                    await NewsAPI().bookmarkNews(widget.news.slug);
                  }

                  setState(() {
                    futureArticle = NewsAPI().fetchNewsBySlug(widget.news.slug);
                  });
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      "${BaseAPI.url}storage/${article.image}",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
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
                    const Divider(height: 20),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: handleBookmark,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              bookmarked ? Colors.blueGrey : Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: bookmarked
                            ? const Text('Unbookmark')
                            : const Text('Bookmark'),
                      ),
                    ),
                    const Divider(height: 20),
                    const Text(
                      'Comments',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        Comment comment = comments[index];
                        return ListTile(
                          title: Text(comment.user.name),
                          subtitle: Text(comment.content),
                          trailing: Text(
                            comment.createdAt.toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                labelText: 'Add a comment...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            color: Colors.blue,
                            onPressed: _addComment,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
