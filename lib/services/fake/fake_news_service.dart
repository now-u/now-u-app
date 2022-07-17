import 'package:app/models/article.dart';
import 'package:app/services/fake/fake_api_service.dart';
import 'package:app/services/news_service.dart';

class FakeNewsService with FakeApiService
    implements NewsService {
  Future<List<Article>> getArticles({Map<String, dynamic>? params}) async {
    Iterable data = await readIterableDataFromFile("news.json");
    return data.map((article) => Article.fromJson(article)).toList();
  }
}
