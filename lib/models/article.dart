import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:nowu/models/exploreable.dart';

// class ArticleType {
//   final String name;
//   final IconData icon;
//
//   ArticleType({
//     required this.name,
//     required this.icon,
//   });
// }
//
// List<ArticleType> articleTypes = [
//   ArticleType(name: "news", icon: CustomIcons.ic_news),
//   ArticleType(name: "video", icon: CustomIcons.ic_video),
// ];

// ArticleType articleTypeFromName(String name) {
//   return articleTypes.firstWhere((ArticleType type) => type.name == name);
// }

class NewsArticle implements Explorable {
  final int id;
  final String title;
  final String subtitle;
  final Api.Image headerImage;
  final DateTime releasedAt;
  final DateTime publishedAt;
  final Uri link;

  NewsArticle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.headerImage,
    required this.releasedAt,
    required this.publishedAt,
    required this.link,
  });

  NewsArticle.fromApiModel(Api.NewsArticle apiModel)
      : id = apiModel.id,
        title = apiModel.title,
        subtitle = apiModel.subtitle,
        headerImage = apiModel.headerImage,
        releasedAt = apiModel.releaseAt,
        publishedAt = apiModel.publishedAt,
        link = Uri.parse(apiModel.link);

  String get shortUrl => link.host;
}
