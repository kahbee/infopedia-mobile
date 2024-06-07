
class Article {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final String slug;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.slug,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
}