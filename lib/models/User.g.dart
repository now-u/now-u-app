// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      email: json['email'] as String?,
      selectedCauseIds:
          (json['cause_ids'] as List<dynamic>).map((e) => e as int).toList(),
      completedCampaignIds: (json['completed_campaigns'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      completedActionIds: (json['completed_actions'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      completedLearningResourceIds:
          (json['completed_learning_resources'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
      fullName: json['full_name'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      location: json['location'] as String?,
      monthlyDonationLimit:
          (json['monthly_donation_limit'] as num?)?.toDouble(),
      homeOwner: json['home_owner'] as bool?,
      points: json['points'],
      organisation: json['organisation'],
    );
