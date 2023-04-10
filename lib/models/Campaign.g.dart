// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCampaign _$ListCampaignFromJson(Map<String, dynamic> json) => ListCampaign(
      id: json['id'] as int,
      title: json['title'] as String,
      shortName: json['short_name'] as String,
      headerImage: json['header_image'] as String,
      completed: json['completed'] as bool,
      cause: causeFromJson(json['causes'] as List),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
    );

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
      id: json['id'] as int,
      title: json['title'] as String,
      headerImage: json['header_image'] as String,
      shortName: json['short_name'] as String,
      completed: json['completed'] as bool,
      cause: causeFromJson(json['causes'] as List),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      videoLink: json['video_link'] as String?,
      description: descriptionFromJson(json['description_app'] as String),
      actions: (json['campaign_actions'] as List<dynamic>)
          .map((e) => ListCauseAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      learningResources: (json['learning_resources'] as List<dynamic>)
          .map((e) => LearningResource.fromJson(e as Map<String, dynamic>))
          .toList(),
      generalPartners: (json['general_partners'] as List<dynamic>?)
              ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      campaignPartners: (json['campaign_partners'] as List<dynamic>?)
              ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      keyAims: (json['key_aims'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
