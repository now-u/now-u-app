import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:nowu/locator.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dynamicLinks.dart';

export 'package:causeApiClient/causeApiClient.dart' show ListCampaign, Campaign;

final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

class ListCampaign {
  int id;
  String title;
  Api.Image headerImage;
  Api.Cause cause;

  ListCampaign({
    required this.id,
    required this.title,
    required this.headerImage,
    required this.cause,
  });

  ListCampaign.fromApiData({
    required this.id,
    required this.title,
    required this.headerImage,
    required BuiltList<Api.Cause> causes,
  }) : cause = causes[0];

  ListCampaign.fromApiModel(Api.ListCampaign apiModel)
      : this.fromApiData(
          id: apiModel.id,
          title: apiModel.title,
          headerImage: apiModel.headerImage,
          causes: apiModel.causes,
        );
}

class Campaign extends ListCampaign {
  String description;
  List<ListAction> actions;
  List<LearningResource> learningResources;

  Campaign({
    required super.id,
    required super.title,
    required super.headerImage,
    required super.cause,
    required this.description,
    required this.actions,
    required this.learningResources,
  });

  Campaign.fromApiModel(Api.Campaign apiModel)
      : description = apiModel.description.replaceAll('\\n', '\n\n'),
        actions = apiModel.actions.map(ListAction.fromApiModel).toList(),
        learningResources = apiModel.learningResources
            .map(LearningResource.fromApiModel)
            .toList(),
        super.fromApiData(
          id: apiModel.id,
          title: apiModel.title,
          headerImage: apiModel.headerImage,
          causes: apiModel.causes,
        );

  Future<String> getShareText() async {
    Uri uri = await _dynamicLinkService.createDynamicLink(
      linkPath: 'campaigns/$id',
      title: title,
      description: description,
      imageUrl: headerImage.url,
    );
    return 'Check out the $title campaign on now-u! ${uri.toString()}';
  }
}
