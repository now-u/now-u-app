import 'package:nowu/assets/components/cause_indicator.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/Campaign.dart';
import 'package:nowu/models/Cause.dart';
import 'package:flutter/material.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:auto_route/auto_route.dart';

import 'campaign_info_viewmodel.dart';

@RoutePage()
class CampaignInfoView extends StackedView<CampaignViewModel> {
  // TODO Work out how to make this work on web url (and internal link()
  final ListCampaign listCampaign;
  CampaignInfoView(this.listCampaign);

  // TODO share this with the explore page header
  Widget _title(void Function() backFunction) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: CustomPaddingSize.small,
          vertical: 20,
        ),
        child: GestureDetector(
          onTap: backFunction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.chevron_left, size: 30),
              Text(
                'Campaign',
                style: exploreHeading,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heading(BuildContext context, ListCampaign campaign) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CustomNetworkImage(
          campaign.headerImage.url,
          height: 193,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(CustomPaddingSize.normal),
          child: Text(
            campaign.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: CustomFontSize.heading3,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _causeIndicator(Cause cause) {
    return Container(
      color: CustomColors.greyLight1,
      height: 43,
      child: CauseIndicator(
        cause,
      ),
    );
  }

  List<Widget> _resourcesList(
    BuildContext context,
    CampaignViewModel viewModel,
  ) {
    if (viewModel.campaign == null) {
      return [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ];
    }

    // Collect all actions and learning materials into a 2 lists of shuffled
    // explore tile widgets.
    List<ExploreResourceTile> actions =
        // TODO FIx false here - should get if complete from service
        viewModel.campaign!.actions
            .map(
              (action) => ExploreActionTile(
                ActionExploreTileData(
                  action,
                  viewModel.actionIsComplete(action.id),
                ),
                onTap: () => viewModel.openAction(action),
              ),
            )
            .toList();
    List<ExploreResourceTile> learningResources =
        viewModel.campaign!.learningResources
            // TODO FIx false here - should get if complete from service
            .map(
              (lr) => ExploreLearningResourceTile(
                LearningResourceExploreTileData(
                  lr,
                  viewModel.learningResourceIsComplete(lr.id),
                ),
                onTap: () => viewModel.openLearningResource(lr),
              ),
            )
            .toList();

    // Combine the lists
    List<ExploreResourceTile> children = <ExploreResourceTile>[];
    children.addAll(actions);
    children.addAll(learningResources);

    // Shuffle and then place completed at the end of the list
    children.shuffle();
    children.sort((a, b) => a.isCompleted == true ? -1 : 1);

    // Add padding to all the elements
    return children
        .map(
          (resource) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              height: 160,
              width: double.infinity,
              child: resource,
            ),
          ),
        )
        .toList();
  }

  Widget _body(BuildContext context, CampaignViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomPaddingSize.small,
        vertical: CustomPaddingSize.normal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Text(
                'About this campaign',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 18),
              ),
              Text(
                viewModel.campaign?.getDescription() ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: CustomPaddingSize.normal),
              Text(
                'Support this campaign by completing these actions',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 18),
              ),
            ] +
            _resourcesList(context, viewModel),
      ),
    );
  }

  @override
  CampaignViewModel viewModelBuilder(BuildContext context) =>
      CampaignViewModel(listCampaign);

  @override
  void onViewModelReady(CampaignViewModel viewModel) => viewModel.init();

  @override
  Widget builder(
    BuildContext context,
    CampaignViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: ListView(
        children: [
          _title(viewModel.back),
          _heading(context, viewModel.listCampaign),
          _causeIndicator(viewModel.listCampaign.cause),
          _body(context, viewModel),
        ],
      ),
    );
  }
}
