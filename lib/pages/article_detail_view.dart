// import 'package:flutter/material.dart';
// import 'package:infopediaflutter/models/article.dart';

// class ArticleDetailPage extends StatelessWidget {
//   final String slug;

//   const ArticleDetailPage({super.key, required this.slug});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(article.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(
//               article.imageUrl,
//               width: double.infinity,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               article.title,
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Published on: ${article.createdAt.toString()}',
//               style: const TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               article.content,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
