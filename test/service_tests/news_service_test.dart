import 'package:app/locator.dart';
import 'package:app/models/article.dart';
import 'package:app/services/news_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/services/api_service.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late NewsService newsService;
  late ApiService mockApiService;

  final article = Article(
    id: 1,
    title: "",
    subtitle: "",
    type: articleTypes[0],
    headerImage: "",
    fullArticleLink: "",
  );

  setUp(() {
    setupLocator();
    mockApiService = MockApiService();
    locator.unregister<ApiService>();
    locator.registerSingleton<ApiService>(mockApiService);
    newsService = locator<NewsService>();

    when(() => mockApiService.getModelListRequest<Article>(any(), any(), params: any(named: "params"), limit: any(named:"limit")))
          .thenAnswer((_) async => [article]);
  });

  group('get causes', () {
    test('calls getMoelListRequest', () async {
      const inputParams = {"test": "params"};
      List<Article> articles = await newsService.getArticles(params: inputParams);
      expect(articles, [article]);

      verify(() => mockApiService.getModelListRequest("articles",
              Article.fromJson, params: inputParams)).called(1);
    });
  });
}
