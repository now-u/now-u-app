import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/assets/components/cause_indicator.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nowu/ui/views/campaign_info/bloc/campaign_info_bloc.dart';
import 'package:nowu/ui/views/campaign_info/bloc/campaign_info_state.dart';
import 'package:tuple/tuple.dart';

@RoutePage()
class CampaignInfoView extends StatelessWidget {
  // TODO Work out how to make this work on web url (and internal link()
  final ListCampaign listCampaign;
  CampaignInfoView(this.listCampaign);

  // TODO share this with the explore page header
  Widget _title(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: CustomPaddingSize.small,
          vertical: 20,
        ),
        child: GestureDetector(
          onTap: () => context.router.maybePop(),
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
    CampaignInfoState state,
  ) {
    switch (state) {
      case CampaignInfoStateInitial():
        return [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ];
      case CampaignInfoStateSuccess(:final campaign):
        List<Tuple2<Widget, bool>> campaignResourceTiles = [];
        campaignResourceTiles.addAll(
          campaign.actions.map(
            (action) => Tuple2(ExploreActionTile(action), action.isCompleted),
          ),
        );
        campaignResourceTiles.addAll(
          campaign.learningResources.map(
            (learningResource) => Tuple2(
              ExploreLearningResourceTile(learningResource),
              learningResource.isCompleted,
            ),
          ),
        );

        // Shuffle and then place completed at the end of the list
        campaignResourceTiles.shuffle();
        campaignResourceTiles.sort((a, b) => a.item2 == true ? -1 : 1);

        return campaignResourceTiles
            .map((tile) => tile.item1)
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

      case CampaignInfoStateFailure():
        return [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('An error occurred'),
            ),
          ),
        ];
    }
  }

  String getCampaignDescription(CampaignInfoState state) {
    switch (state) {
      case CampaignInfoStateInitial():
      case CampaignInfoStateFailure():
        return '';
      case CampaignInfoStateSuccess(:final campaign):
        return campaign.description;
    }
  }

  Widget _body(BuildContext context, CampaignInfoState state) {
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
                getCampaignDescription(state),
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
            _resourcesList(context, state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => CampaignInfoBloc(causesService: locator<CausesService>())
          ..fetchCampaign(listCampaign.id),
        child: BlocBuilder<CampaignInfoBloc, CampaignInfoState>(
          builder: (context, state) {
            return ListView(
              children: [
                _title(context),
                _heading(context, listCampaign),
                _causeIndicator(listCampaign.cause),
                _body(context, state),
              ],
            );
          },
        ),
      ),
    );
  }
}
