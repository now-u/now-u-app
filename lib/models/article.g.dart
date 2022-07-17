// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    id: json['id'] as int,
    title: json['name'] as String,
    subtitle: json['subtitle'] as String,
    type: articleTypeFromName(json['type'] as String),
    headerImage: json['header_image'] as String,
    fullArticleLink: json['full_article_link'] as String,
    source: json['source'] as String?,
    linkedCampaignId: json['linked_campaign_id'] as int?,
    releasedAt: json['released_at'] == null
        ? null
        : DateTime.parse(json['released_at'] as String),
  );
}
