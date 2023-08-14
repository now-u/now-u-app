import 'package:nowu/models/article.dart';

import './factory.dart';

class ArticleFactory extends ModelFactory<NewsArticle> {
  @override
  NewsArticle generate() {
    return NewsArticle(
      (article) => article
        ..id = faker.randomGenerator.integer(100)
        ..title = faker.lorem.sentence()
        ..subtitle = faker.lorem.sentence()
        ..headerImage = faker.image.image()
        // TODO Add source to news article
        // ..source = "bbc news"
        // TODO Add type to article
        // ..type = articleTypes[0]
        ..link = faker.internet.httpUrl(),
    );
  }
}
