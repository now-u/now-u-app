import 'package:nowu/models/article.dart';

import './factory.dart';
import 'image_factory.dart';

class ArticleFactory extends ModelFactory<NewsArticle> {
  @override
  NewsArticle generate() {
    return NewsArticle(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      subtitle: faker.lorem.sentence(),
      headerImage: ImageFactory().generate(),
      link: Uri.parse(faker.internet.httpsUrl()),
      releasedAt: faker.date.dateTime(),
      publishedAt: faker.date.dateTime(),
    );
  }
}
