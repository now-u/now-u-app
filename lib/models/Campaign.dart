import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/dynamicLinks.dart';

export 'package:causeApiClient/causeApiClient.dart' show ListCampaign, Campaign;

final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

extension ListCampaignExtension on ListCampaign {
  Cause get cause => this.causes[0];
}

extension CampaignExtension on Campaign {
  Cause get cause {
    print('Getting cause for action ${id} ${title}');
    return this.causes[0];
  }

  // TODO This is really sad, it would be easy to use description by accident
  String getDescription() => this.description.replaceAll('\\n', '\n\n');

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
