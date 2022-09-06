// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Learning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningResource _$LearningResourceFromJson(Map<String, dynamic> json) =>
    LearningResource(
      id: json['id'] as int,
      title: json['title'] as String,
      time: (json['time'] as num).toDouble(),
      link: json['link'] as String,
      type: getResourceTypeFromString(json['type'] as String?),
      createdAt: DateTime.parse(json['created_at'] as String),
      completed: authBooleanSerializer(json['completed']),
      cause: causeFromJson(json['causes'] as List),
      source: json['source'] as String?,
    );
