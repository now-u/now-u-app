import 'package:app/models/Explorable.dart';
import 'package:intl/intl.dart';

class ListNews extends Explorable {
  final int id;

  final String title;
  final String desc;

  final String headerImage;

  final DateTime date;

  String get dateString => DateFormat("d MMM y").format(date);

  final String url;
  final String shortUrl;

  ListNews({
    required this.id,
    required this.title,
    required this.desc,
    required this.headerImage,
    required this.date,
    required this.url,
  }) : shortUrl = Uri.parse(url).host;

  // FIXME temporary only, should check with API requirements
  ListNews.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        desc = json["desc"],
        headerImage = json["image"],
        date = json["date"],
        url = json["url"],
        shortUrl = Uri.parse(json["url"]).host;
}
