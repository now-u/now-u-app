import 'package:app/models/article.dart';

import './factory.dart';

class ArticleFactory extends ModelFactory<Article> {
  @override
  Article generate() {
    return Article(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      subtitle: faker.lorem.sentence(),
      headerImage: faker.image.image(),
      // type: articleTypes[0],
      fullArticleLink: faker.internet.httpUrl(),
      source: "bbc news",
    );
  }
}
