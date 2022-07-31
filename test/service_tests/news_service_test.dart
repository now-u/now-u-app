import 'package:app/locator.dart';
import 'package:app/models/article.dart';
import 'package:app/services/news_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:app/services/api_service.dart';

import '../setup/test_helpers.dart';
import '../setup/test_helpers.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  locator.registerSingleton<ApiService>(mockApiService);
  NewsService _newsService = locator<NewsService>();

  group('get causes', () {
    test('returns a List of ListCauses if the request is successfully',
        () async {
      // final client = MockClient();
      // _newsService.client = client;
      
      when(mockApiService.getListRequest(any, params: anyNamed("params")))
        .thenAnswer((_) async => [{"dummy": "data1"}, {"dummy": "data2"}]);

      // when(client.get(Uri.parse('https://api.now-u.com/api/v2/articles'),
      //         headers: unauthenticatedHeaders))
      //     .thenAnswer(
      //         (_) async => http.Response(await readTestData("news.json"), 200));

      List<Article> articles = await _newsService.getArticles();
      expect(articles.length, 2);

      Article article = articles[0];
      expect(article.id, 233);
      expect(article.title,
          "Billions risk being without access to water and sanitation services by 2030");
      expect(article.headerImage,
          "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/01-07-2021_UNICEF-280215_Jordan.jpg/image1170x530cropped.jpg");
      expect(article.subtitle,
          "Without an urgent injection of cash, billions globally are at risk of still being without lifesaving access to safe drinking water, sanitation and hygiene services by 2030, according to a new UN report published on Thursday.");
    });

    // TODO error case
  });
}
