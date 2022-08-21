// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cause.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCause _$ListCauseFromJson(Map<String, dynamic> json) => ListCause(
      id: json['id'] as int,
      title: json['name'] as String,
      icon: getIconFromString(json['icon'] as String),
      description: json['description'] as String,
      headerImage: json['image'] as String,
      selected: authBooleanSerializer(json['completed']),
    );
