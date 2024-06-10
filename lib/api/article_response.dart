import 'package:infopediaflutter/models/article.dart';

class ArticleResponse {
  ArticleResponse({required this.news, required this.comments, required this.bookmarked});

  final Article news;
  final List<Comment> comments;
  final bool bookmarked;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];
    json["comments"].forEach((comment) {
      comments.add(Comment.fromJson(comment));
    });
    return ArticleResponse(
      news: Article.fromJson(json["news"]),
      comments: comments,
      bookmarked: json["bookmarked"],
    );
  }
}
