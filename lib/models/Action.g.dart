// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCauseAction _$ListCauseActionFromJson(Map<String, dynamic> json) =>
    ListCauseAction(
      id: json['id'] as int,
      title: json['title'] as String,
      type: campaignActionTypeFromString(json['type'] as String?),
      cause: causeFromJson(json['causes'] as List),
      completed: json['completed'] as bool,
      time: (json['time'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      releasedAt: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
    );

CampaignAction _$CampaignActionFromJson(Map<String, dynamic> json) =>
    CampaignAction(
      id: json['id'] as int,
      title: json['title'] as String,
      type: campaignActionTypeFromString(json['type'] as String?),
      cause: causeFromJson(json['causes'] as List),
      completed: json['completed'] as bool,
      time: (json['time'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      releasedAt: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      whatDescription: json['what_description'] as String?,
      whyDescription: json['why_description'] as String?,
      link: json['link'] as String?,
    );
