import 'package:app/locator.dart';
import 'package:app/models/article.dart';
import 'package:app/services/news_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/services/api_service.dart';
import 'package:mocktail/mocktail.dart';

import '../factories/article_factory.dart';
import '../setup/test_helpers.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late NewsService newsService;
  late ApiService mockApiService;

  final article = ArticleFactory().generate();

  setUp(() {
    setupLocator();
    mockApiService = MockApiService();
    registerMock<ApiService>(mockApiService);
    newsService = locator<NewsService>();

    when(() => mockApiService.getModelListRequest<Article>(any(), any(),
        params: any(named: "params"),
        limit: any(named: "limit"))).thenAnswer((_) async => [article]);
  });

  group('get articles', () {
    test('calls getModelListRequest', () async {
      const inputParams = {"test": "params"};
      List<Article> articles =
          await newsService.getArticles(params: inputParams);
      expect(articles, [article]);

      verify(() => mockApiService.getModelListRequest(
          "v1/articles", Article.fromJson,
          params: inputParams)).called(1);
    });
  });
}
