import 'package:app/services/api_service.dart';
import 'package:app/models/article.dart';
import 'package:app/locator.dart';

class NewsService {
  final ApiService _apiService = locator<ApiService>();

  Future<List<Article>> getArticles({Map<String, dynamic>? params}) async {
    return _apiService.getModelListRequest("articles", Article.fromJson, params: params);
  }
}
