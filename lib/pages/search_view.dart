import 'package:flutter/material.dart';
import 'package:infopediaflutter/models/news.dart';
import 'package:infopediaflutter/api/news_api.dart';
import 'package:infopediaflutter/pages/news_list_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi futureNews dengan berita kosong
    futureNews = Future.value([]);
  }

  void _search() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      futureNews = NewsAPI().searchNews(query);
    } else {
      // Menetapkan futureNews sebagai Future kosong jika query kosong
      futureNews = Future.value([]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        // Tidak perlu panggil _search saat teks berubah
                        // _search();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Cari berita...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: const Color.fromARGB(255, 61, 63, 65),
                    onPressed: _search,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<News>>(
                future: futureNews,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Berita tidak dapat ditemukan'));
                  } else {
                    return NewsListWidget(futureNews: futureNews);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
