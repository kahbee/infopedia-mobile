class News {
  int id;
  String title;
  String content;
  String image;
  String slug;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.slug,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      slug: json['slug'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
