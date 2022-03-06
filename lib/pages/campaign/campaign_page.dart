import 'package:app/assets/components/cause_indicator.dart';
import 'package:app/assets/components/custom_network_image.dart';
import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/assets/constants.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:app/pages/campaign/campaign_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CampaignPage extends StatelessWidget {

  final ListCampaign listCampaign;
  CampaignPage(this.listCampaign);

  // TODO share this with the explore page header
  Widget _title(void Function() backFunction) {
    return SafeArea(
      child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: CustomPaddingSize.small, vertical: 20),
      child: GestureDetector(
        onTap: backFunction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.chevron_left, size: 30),
            Text(
              "Campaign",
              style: exploreHeading,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _heading(BuildContext context, ListCampaign campaign) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CustomNetworkImage(
          campaign.headerImage,
          height: 193,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.all(CustomPaddingSize.small),
          child: Text(
            campaign.title,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: CustomFontSize.heading1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _causeIndicator(ListCause cause) {
    return Container(
      color: CustomColors.greyLight1,
      height: 43,
      child: CauseIndicator(
        cause,
      ),
    );
  }

  List<Widget> _resourcesList(BuildContext context, Campaign? campaign) {
    if (campaign == null) {
      return [CircularProgressIndicator()];
    }

    double tileWidth = (MediaQuery.of(context).size.width - CustomPaddingSize.small * 2);

    List<ExploreTile> actions = campaign.actions.map((action) => ExploreActionTile(action, style: ExploreTileStyle.Extended)).toList();
    List<ExploreTile> learningResources = campaign.learningResources.map((lr) => ExploreLearningTile(lr, style: ExploreTileStyle.Extended)).toList();
    // List<BaseExtendedExploreActionTile> children = actions + learningResources;
    List<ExploreTile> children = <ExploreTile>[];
    children.addAll(actions);
    children.addAll(learningResources);

    children.shuffle();
    children.sort((a, b) => a.completed! ? -1 : 1);

    // TODO move tile heights to explore widget
    // Wrap widgets in containers with correct height
    return children.map((resource) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: resource,
      )
    ).toList();
  }

  Widget _body(BuildContext context, Campaign? campaign) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CustomPaddingSize.small, vertical: CustomPaddingSize.normal),
      child: Column(
        children: <Widget>[
          Text(
            "Support this campaign by completing these actions:",
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
        ] + _resourcesList(context, campaign),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<CampaignViewModel>.reactive(
          viewModelBuilder: () => CampaignViewModel(listCampaign),
          onModelReady: (model) => model.init(),
          builder: (context, model, child) {
            return ListView(
              children: [
                _title(model.back),
                _heading(context, model.listCampaign),
                _causeIndicator(model.listCampaign.cause),
                _body(context, model.campaign),
              ]
            );
          },
        ),
    );
  }
}
