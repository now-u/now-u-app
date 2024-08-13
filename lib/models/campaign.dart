import 'package:built_collection/built_collection.dart';
import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:nowu/models/exploreable.dart';
import 'package:nowu/models/user.dart';
import 'package:nowu/services/causes_service.dart';

class Campaign extends ListCampaign {
  String description;
  List<ListAction> actions;
  List<LearningResource> learningResources;

  Campaign({
    required super.id,
    required super.title,
    required super.headerImage,
    required super.cause,
    required super.isCompleted,
    required this.description,
    required this.actions,
    required this.learningResources,
  });

  Campaign.fromApiModel(Api.Campaign apiModel, CausesUser? causesUser)
      : description = apiModel.description.replaceAll('\\n', '\n\n'),
        actions = apiModel.actions
            .map(
              (action) => ListAction.fromApiModel(
                action,
                causesUser,
              ),
            )
            .toList(),
        learningResources = apiModel.learningResources
            .map(
              (learningResource) => LearningResource.fromApiModel(
                learningResource,
                causesUser,
              ),
            )
            .toList(),
        super.fromApiData(
          id: apiModel.id,
          title: apiModel.title,
          headerImage: apiModel.headerImage,
          causes: apiModel.causes,
          causesUser: causesUser,
        );

  Future<String> getShareText() async {
    // TODO: Uri uri = await _dynamicLinkService.createDynamicLink(
    //   linkPath: 'campaigns/$id',
    //   title: title,
    //   description: description,
    //   imageUrl: headerImage.url,
    // );
    // return 'Check out the $title campaign on now-u! ${uri.toString()}';
    return '';
  }
}

class ListCampaign implements Explorable {
  int id;
  String title;
  Api.Image headerImage;
  Cause cause;
  bool isCompleted;

  ListCampaign({
    required this.id,
    required this.title,
    required this.headerImage,
    required this.cause,
    required this.isCompleted,
  });

  ListCampaign.fromApiData({
    required this.id,
    required this.title,
    required this.headerImage,
    required BuiltList<Api.Cause> causes,
    required CausesUser? causesUser,
  })  : cause = Cause.fromApiModel(causes[0], causesUser),
        isCompleted = causesUser?.completedCampaignIds.contains(id) ?? false;

  ListCampaign.fromApiModel(Api.ListCampaign apiModel, CausesUser? causesUser)
      : this.fromApiData(
          id: apiModel.id,
          title: apiModel.title,
          headerImage: apiModel.headerImage,
          causes: apiModel.causes,
          causesUser: causesUser,
        );
}
