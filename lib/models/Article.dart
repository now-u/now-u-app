import 'package:app/assets/icons/customIcons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/models/Campaign.dart';

class ArticleType {
  final String name;
  final IconData icon;

  ArticleType({
    required this.name,
    required this.icon,
  });
}

List<ArticleType> articleTypes = [
  ArticleType(name: "news", icon: CustomIcons.ic_news),
  ArticleType(name: "video", icon: CustomIcons.ic_video),
];

ArticleType articleTypeFromName(String name) {
  return articleTypes.firstWhere((ArticleType type) => type.name == name);
}

class Article {
  final int id;
  final String title;
  final String subtitle;
  final ArticleType type;
  final String headerImage;
  final DateTime? releasedAt;
  final String? source;
  final String fullArticleLink;
  final int? linkedCampaignId;

  Article({
    required int id,
    required String title,
    required String subtitle,
    required ArticleType type,
    required String headerImage,
    required String fullArticleLink,
    String? source,
    int? linkedCampaignId,
    DateTime? releasedAt,
  }) :
    id = id,
    title = title,
    subtitle = subtitle,
    type = type,
    headerImage = headerImage,
    fullArticleLink = fullArticleLink,
    source = source,
    releasedAt = releasedAt,
    linkedCampaignId = linkedCampaignId;

  Article.fromJson(Map json) :
    id = json['id'],
    title = json['title'],
    subtitle = json['subtitle'],
    headerImage = json['header_image'],
    releasedAt = DateTime.parse(json['released_at']),
    fullArticleLink = json['full_article_link'],
    source = json['source'],
    type = articleTypeFromName(json['type']),
    linkedCampaignId = json['campaign_id'];

  String? getCategory({List<Campaign>? campaigns}) {
    if (linkedCampaignId != null && campaigns != null) {
      for (int i = 0; i < campaigns.length; i++) {
        if (campaigns[i].id == linkedCampaignId) return campaigns[i].shortName;
      }
    }
    return "General";
  }
}
