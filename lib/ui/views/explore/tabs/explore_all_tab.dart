import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';

import '../explore_page_viewmodel.dart';
import '../filters/explore_filter_chip.dart';
import 'explore_tab.dart';

class ExploreAllTab extends StatelessWidget {
  final ExplorePageViewModel viewModel;

  const ExploreAllTab(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExploreTab(
      filterChips: [
        CausesFilter(viewModel: viewModel),
		NewFilter(viewModel: viewModel),
      ],
      filterResults: [
		ActionExploreSection(
			ActionExploreSectionArgs(
    		  title: 'Actions',
    		  link: const BaseResourceSearchFilter(resourceTypes: [ResourceType.ACTION]),
    		  description:
    		      'Take a wide range of actions to drive lasting change for issues you care about',
    		),
		),
	  ]
    );
  }
}
