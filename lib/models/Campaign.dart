import 'package:flutter/foundation.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/SDG.dart';
import 'package:app/models/Cause.dart';

import 'package:app/locator.dart';
import 'package:app/services/dynamicLinks.dart';

final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

class ListCampaign {
  /// API id for header image
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;

  String _shortName;
  String get shortName => _shortName;

  /// Url of header image
  String _headerImage;
  String get headerImage => _headerImage;

  DateTime? _startDate;
  DateTime? get startDate => _startDate;

  DateTime? _endDate;
  DateTime? get endDate => _endDate;

  /// Has the user completed this campaign
  bool _completed;
  bool get isCompleted => _completed;

  /// The causes that this campaign is part of
  List<ListCause> _causes;
  // Although at the api level a campaign can be in many causes, for now we are
  // only showing a single cause in the UI.
  ListCause? get cause => _causes.length > 0 ? _causes[0] : null;

  /// Returns whether the campaign has ended
  bool get isPast =>
      _endDate == null ? false : DateTime.now().compareTo(_endDate!) > 0;

  ListCampaign({
    required int id,
    required String title,
    required String shortName,
    required String headerImage,
    required bool completed,
    required List<ListCause> causes,
    DateTime? startDate,
    DateTime? endDate,
  })  : _id = id,
        _title = title,
        _shortName = shortName,
        _headerImage = headerImage,
        _completed = completed,
        _causes = causes,
        _startDate = startDate,
        _endDate = endDate;

  ListCampaign.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _title = json['title'],
        _shortName = json['short_name'],
        _headerImage = json['header_image'],
        _startDate = json['start_date'],
        _endDate = json['end_date'],
        _completed = json['completed'],
        _causes = json['causes']
            .map((causeJson) => ListCause.fromJson(causeJson))
            .toList()
            .cast<ListCause>();
}

class Campaign extends ListCampaign {
  String _description;
  String get description => _description.replaceAll('\\n', '\n\n');

  String? _videoLink;
  String? get videoLink => _videoLink;

  String? _infographicUrl;
  String? get infographic => _infographicUrl;

  List<Organisation>? _generalPartners;
  List<Organisation>? get generalPartners => _generalPartners;

  List<Organisation>? _campaignPartners;
  List<Organisation>? get campaignPartners => _campaignPartners;

  List<ListCauseAction>? _actions;
  List<ListCauseAction>? get actions => _actions;

  List<String>? _keyAims;
  List<String>? get keyAims => _keyAims;

  int? _numberOfCampaigners;
  int? get numberOfCampaigners => _numberOfCampaigners;
  int? _numberOfActionsCompleted;
  int? get numberOfActionsCompleted => _numberOfActionsCompleted;

  Campaign({
    // Super attributes
    required int id,
    required String title,
    required String headerImage,
    required String shortName,
    required bool completed,
    required List<ListCause> causes,
    DateTime? startDate,
    DateTime? endDate,
    required String description,
    required List<CampaignAction> actions,
    required String videoLink,
    required String infographicUrl,
    required int numberOfCampaigners,
    required int numberOfActionsCompleted,
    List<Organisation>? generalPartners,
    List<Organisation>? campaignPartners,
    List<String>? keyAims,
  })  :
        // Default lists to empty
        _description = description,
        _generalPartners = generalPartners ?? [],
        _campaignPartners = campaignPartners ?? [],
        _keyAims = keyAims ?? [],
        _videoLink = videoLink,
        _infographicUrl = infographicUrl,
        _numberOfCampaigners = numberOfCampaigners,
        _numberOfActionsCompleted = numberOfActionsCompleted,
        super(
            id: id,
            title: title,
            headerImage: headerImage,
            shortName: shortName,
            startDate: startDate,
            endDate: endDate,
            completed: completed,
            causes: causes);

  Campaign.fromJson(Map<String, dynamic> json)
      : _description = json['description_app'],
        _numberOfCampaigners = json['number_of_campaigners'],
        _numberOfActionsCompleted = json['number_of_completed_actions'],
        _infographicUrl = json['infographic_url'],
        _actions = json['actions']
            .map((e) => ListCauseAction.fromJson(e))
            .toList()
            .cast<ListCauseAction>(),
        _campaignPartners = json['campaign_partners']
            .map((e) => Organisation.fromJson(e))
            .toList()
            .cast<Organisation>(),
        _generalPartners = json['general_partners']
            .map((e) => Organisation.fromJson(e))
            .toList()
            .cast<Organisation>(),
        _videoLink = json['video_link'],
        _keyAims =
            json['key_aims'].map((a) => a['title']).toList().cast<String>(),
        super.fromJson(json);

  Future<String> getShareText() async {
    Uri uri = await _dynamicLinkService.createDynamicLink(
      linkPath: "campaigns/$_id",
      title: title,
      description: description,
      imageUrl: headerImage,
    );
    return "Check out the $title campaign on now-u! ${uri.toString()}";
  }
}
