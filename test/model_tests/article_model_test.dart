import 'dart:convert';
import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/article.dart';
import 'package:flutter_test/flutter_test.dart';

import '../setup/test_helpers.dart';

void main() {
  group('Article from json -', () {
    test('Happy Article json test', () async {
      final data  = await readTestData("news.json");
      List<Map<String, dynamic>> listData = new List<Map<String, dynamic>>.from(json.decode(data)["data"]);

      final article = Article.fromJson(listData[0]);

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
