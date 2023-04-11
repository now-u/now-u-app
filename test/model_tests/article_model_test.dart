import 'package:flutter_test/flutter_test.dart';
import 'package:nowu/models/article.dart';

import './helpers.dart';

void main() {
  group('Article from json -', () {
    test('Happy Article json test', () async {
      final data = await readTestDataList("news.json");
      final article = Article.fromJson(data[0]);

      expect(article.id, 233);
      expect(article.title,
          "Billions risk being without access to water and sanitation services by 2030");
      expect(article.headerImage,
          "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/01-07-2021_UNICEF-280215_Jordan.jpg/image1170x530cropped.jpg");
      expect(article.subtitle,
          "Without an urgent injection of cash, billions globally are at risk of still being without lifesaving access to safe drinking water, sanitation and hygiene services by 2030, according to a new UN report published on Thursday.");
    });
  });
}
