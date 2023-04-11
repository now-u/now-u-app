import 'package:nowu/assets/components/cause_indicator.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/Campaign.dart';
import 'package:nowu/models/Cause.dart';
import 'package:nowu/pages/campaign/campaign_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CampaignPage extends StatelessWidget {
  final ListCampaign listCampaign;
  CampaignPage(this.listCampaign);

  // TODO share this with the explore page header
  Widget _title(void Function() backFunction) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CustomPaddingSize.small, vertical: 20),
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

    // Collect all actions and learning materials into a 2 lists of shuffled
    // explore tile widgets.
    List<ExploreResourceTile> actions =
        campaign.actions.map((action) => ExploreActionTile(action)).toList();
    List<ExploreResourceTile> learningResources = campaign.learningResources
        .map((lr) => ExploreLearningTile(lr))
        .toList();

    // Combine the lists
    List<ExploreResourceTile> children = <ExploreResourceTile>[];
    children.addAll(actions);
    children.addAll(learningResources);

    // Shuffle and then place completed at the end of the list
    children.shuffle();
    children.sort((a, b) => a.completed ? -1 : 1);

    // Add padding to all the elements
    return children
        .map((resource) => Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: resource,
            ))
        .toList();
  }

  Widget _body(BuildContext context, Campaign? campaign) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CustomPaddingSize.small,
          vertical: CustomPaddingSize.normal),
      child: Column(
        children: <Widget>[
              Text(
                "Support this campaign by completing these actions:",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ] +
            _resourcesList(context, campaign),
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
          return ListView(children: [
            _title(model.back),
            _heading(context, model.listCampaign),
            _causeIndicator(model.listCampaign.cause),
            _body(context, model.campaign),
          ]);
        },
      ),
    );
  }
}
