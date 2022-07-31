import 'package:app/locator.dart';
import 'package:app/models/article.dart';
import 'package:app/services/news_service.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:app/services/api_service.dart';

import '../setup/test_helpers.dart';
// import '../setup/test_helpers.mocks.dart';

import 'package:mocktail/mocktail.dart';
import 'package:app/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  setupLocator();

      final article = Article(
        id: 1,
        title: "",
        subtitle: "",
        type: articleTypes[0],
        headerImage: "",
        fullArticleLink: "",
      );
  ApiService mockApiService = MockApiService();
  when(() async => mockApiService.getModelListRequest(any(), any(), params: any(named: "params")))
        .thenAnswer((_) async => [article]);
  locator.unregister<ApiService>();
  locator.registerSingleton<ApiService>(mockApiService);
  NewsService _newsService = locator<NewsService>();

  group('get causes', () {
    test('returns a List of ListCauses if the request is successfully',
        () async {
      // final client = MockClient();
      // _newsService.client = client;

      List<Article> articles = await _newsService.getArticles();

      verify(() async => mockApiService.getModelListRequest(any(), any(), params: any(named: "params")))
          .called(1);
    });

    // TODO error case
  });
}
