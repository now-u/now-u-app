import 'package:nowu/services/api_service.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/locator.dart';

class NewsService {
  final ApiService _apiService = locator<ApiService>();

  Future<List<Article>> getArticles({Map<String, dynamic>? params}) async {
    return _apiService.getModelListRequest("v1/articles", Article.fromJson,
        params: params);
  }
}
