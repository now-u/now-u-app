import 'package:causeApiClient/causeApiClient.dart';
import 'package:intl/intl.dart';

export 'package:causeApiClient/causeApiClient.dart' show NewsArticle;

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

extension NewsArticleExtension on NewsArticle {
  String? get dateString {
    return releaseAt != null ? DateFormat('d MMM y').format(releaseAt!) : null;
  }

  // TODO Try harder
  String? getCategory({List<Campaign>? campaigns}) {
    return 'General';
  }

  String get shortUrl => Uri.parse(link).host;
}
