import 'package:app/locator.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/services/dynamicLinks.dart';

final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

class ListCampaignSerializer extends Serializer<ListCampaign> {
  ListCampaign fromJson(Map<String, dynamic> data) {
    return ListCampaign.fromJson(data);
  }
}

class ListCampaign extends Explorable {
  /// API id for header image
  final int id;
  final String title;
  final String shortName;

  /// Url of header image
  final String headerImage;
  final DateTime? startDate;
  final DateTime? endDate;

  /// Has the user completed this campaign
  final bool completed;

  /// The cause that this campaign is part of
  // Although at the api level a campaign can be in many causes, for now we are
  // only showing a single cause in the UI.
  final ListCause cause;

  /// Returns whether the campaign has ended
  bool get isPast =>
      endDate == null ? false : DateTime.now().compareTo(endDate!) > 0;

  ListCampaign({
    required this.id,
    required this.title,
    required this.shortName,
    required this.headerImage,
    required this.completed,
    required List<ListCause> causes,
    this.startDate,
    this.endDate,
  }) : cause = causes[0];

  ListCampaign.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        shortName = json['short_name'],
        headerImage = json['header_image'],
        startDate = DateTime.parse(json['start_date']),
        endDate = DateTime.parse(json['end_date']),
        completed = json['completed'] == true,
        cause = ListCause.fromJson(json['causes'][0]);
}

class Campaign extends ListCampaign {
  final String description;
  final String videoLink;
  final String infographicUrl;

  final List<Organisation> generalPartners;
  final List<Organisation> campaignPartners;

  final List<String> keyAims;

  final List<ListCauseAction> actions;
  final List<LearningResource> learningResources;

  final int numberOfCampaigners;
  final int numberOfActionsCompleted;

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
    required this.description,
    required this.actions,
    required this.learningResources,
    required this.videoLink,
    required this.infographicUrl,
    required this.numberOfCampaigners,
    required this.numberOfActionsCompleted,
    this.generalPartners = const [],
    this.campaignPartners = const [],
    this.keyAims = const [],
  }) : super(
          id: id,
          title: title,
          headerImage: headerImage,
          shortName: shortName,
          startDate: startDate,
          endDate: endDate,
          completed: completed,
          causes: causes,
        );

  Campaign.fromJson(Map<String, dynamic> json)
      : description = json['description_app'].replaceAll('\\n', '\n\n'),
        // numberOfCampaigners = json['number_of_campaigners'],
        // numberOfActionsCompleted = json['number_of_completed_actions'],
        numberOfCampaigners = 0,
        numberOfActionsCompleted = 0,
        infographicUrl = json['infographic_url'],
        actions = json['campaign_actions']
            .map((e) => ListCauseAction.fromJson(e,
                cause: ListCause.fromJson(json['causes'][0])))
            .toList()
            .cast<ListCauseAction>(),
        learningResources = json['learning_resources']
            .map((e) => LearningResource.fromJson(e,
                cause: ListCause.fromJson(json['causes'][0])))
            .toList()
            .cast<LearningResource>(),
        videoLink = json['video_link'],
        // generalPartners = json['general_partners']
        //     .map((e) => Organisation.fromJson(e))
        //     .toList()
        //     .cast<Organisation>(),
        // keyAims =
        //     json['key_aims'].map((a) => a['title']).toList().cast<String>(),
        // campaignPartners = json['campaign_partners']
        //     .map((e) => Organisation.fromJson(e))
        //     .toList()
        //     .cast<Organisation>(),
        keyAims = [],
        campaignPartners = [],
        generalPartners = [],
        super.fromJson(json);

  Future<String> getShareText() async {
    Uri uri = await _dynamicLinkService.createDynamicLink(
      linkPath: "campaigns/$id",
      title: title,
      description: description,
      imageUrl: headerImage,
    );
    return "Check out the $title campaign on now-u! ${uri.toString()}";
  }
}
