import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app/models/Article.dart';

class NewsService {
  String domainPrefix = "https://api.now-u.com/api/v1/";

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  Future fetchArticles() async {
    try {
      var response = await http.get(domainPrefix + "articles");
      _articles = json
          .decode(response.body)['data']
          .map((e) => Article.fromJson(e))
          .toList()
          .cast<Article>();
    } catch (e) {}
  }
}
