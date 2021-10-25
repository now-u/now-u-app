import 'package:app/assets/icons/customIcons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/models/Campaign.dart';

class ArticleType {
  String name;
  IconData icon;

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
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;
  
  String _subtitle;
  String get subtitle => _subtitle;

  ArticleType _type;
  ArticleType get type => _type;

  String _headerImage;
  String get headerImage => _headerImage;

  DateTime? _releasedAt;
  DateTime? get releasedAt => _releasedAt;

  String? _source;
  String? get source => _source;

  String _fullArticleLink;
  String get fullArticleLink => _fullArticleLink;

  int? _linkedCampaignId;

  Article({
    required int id,
    required String title,
    required String subtitle,
    required ArticleType type,
    required String headerImage,
    required String fullArticleLink,
    String? source,
    int? linkedCampaignId
  }) :
    _id = id,
    _title = title,
    _subtitle = subtitle,
    _type = type,
    _headerImage = headerImage,
    _fullArticleLink = fullArticleLink,
    _source = source,
    _linkedCampaignId = linkedCampaignId;

  Article.fromJson(Map json) :
    _id = json['id'],
    _title = json['title'],
    _subtitle = json['subtitle'],
    _headerImage = json['header_image'],
    _releasedAt = DateTime.parse(json['released_at']),
    _fullArticleLink = json['full_article_link'],
    _source = json['source'],
    _type = articleTypeFromName(json['type']),
    _linkedCampaignId = json['campaign_id'];

  String? getCategory({List<Campaign>? campaigns}) {
    if (_linkedCampaignId != null && campaigns != null) {
      for (int i = 0; i < campaigns.length; i++) {
        if (campaigns[i].id == _linkedCampaignId) return campaigns[i].shortName;
      }
    }
    return "General";
  }
}
