import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';

import '../explore_page_viewmodel.dart';
import '../filters/explore_filter_chip.dart';
import 'explore_tab.dart';

class ExploreCampaignTab extends StatelessWidget {
  final ExplorePageViewModel viewModel;

  const ExploreCampaignTab(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExploreTab(
      filterChips: [
        CausesFilter(viewModel: viewModel),
        NewFilter(viewModel: viewModel),
        RecommendedFilter(viewModel: viewModel),
        CompletedFilter(viewModel: viewModel),
      ],
      filterResults: viewModel.campaigns.map<Widget>(
        (campaign) => Container(
          // TODO Create shared constant for these/ pull. from ExploreSectionArgs
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ExploreCampaignTile(
              CampaignExploreTileData(
                  campaign, viewModel.isCampaignComplete(campaign),),
              onTap: () => viewModel.openCampaign(campaign),
            ),
          ),
        ),
      ),
    );
  }
}
