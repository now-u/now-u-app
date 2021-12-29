import 'package:app/services/api_service.dart';
import 'package:app/models/article.dart';

class NewsService extends ApiService {
  Future<List<Article>> getArticles({Map<String, dynamic>? params}) async {
    List<Map<String, dynamic>> data = await getListRequest("articles", params: params);
    return data.map((article) => Article.fromJson(article)).toList();
  }
}
