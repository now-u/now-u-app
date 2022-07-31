// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    id: json['id'] as int,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    type: articleTypeFromName(json['type'] as String),
    headerImage: json['header_image'] as String,
    fullArticleLink: json['full_article_link'] as String,
    source: json['source'] as String?,
    linkedCampaignId: json['campaignId'] as int?,
    releasedAt: json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
  );
}
