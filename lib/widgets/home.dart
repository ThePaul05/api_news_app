import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/class/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<News>> newsFuture = getNews();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Noticias"),
      ),
      body: Center(
        child: FutureBuilder(
          future: newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final news = snapshot.data as List<News>;
              return buildNews(news);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  static Future<List<News>> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=149bdbf5674b4098aa5e830c9595647d");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);
    final List articles = body['articles'];
    return articles.map((e) => News.fromJson(e)).toList();
  }
}

Widget buildNews(List<News> news) {
  return ListView.separated(
    itemCount: news.length,
    itemBuilder: (BuildContext context, int index) {
      final n = news[index];
      final url = n.url;

      return ListTile(
        title: Text(n.name!),
        leading: CircleAvatar(backgroundImage: NetworkImage(url!)),
        subtitle: Text(n.description!),
        trailing: const Icon(Icons.arrow_forward_ios),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return const Divider(
        thickness: 2,
      );
    },
  );
}
