import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/searchBar.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';
import 'package:stacked/stacked.dart';

import 'explore_page_viewmodel.dart';

final double horizontalPadding = CustomPaddingSize.small;

class ExplorePage extends StatelessWidget {
  final ExplorePageArguments args;

  ExplorePage(this.args, {Key? key}) : super(key: key);

  final _searchBarFocusNode = FocusNode();

  Widget _header(BuildContext context, ExplorePageViewModel model) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: model.canGoBack ? model.back : null,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (model.canGoBack)
                      const Icon(Icons.chevron_left, size: 30),
                    Text(
                      model.title,
                      style: exploreHeading,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 8,
              ),
              child: SearchBar(
                onTap: () {
                  model.navigateToSearchPage();
                  _searchBarFocusNode.unfocus();
                },
                focusNode: _searchBarFocusNode,
              ),
            ),
            if (model.hasLinks())
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    // Map section arguments into real sections
                    children: model.sections
                        .where((section) => section.link != null)
                        .map(
                          (section) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DarkButton(
                              section.title,
                              onPressed: () => model.changePage(section.link!),
                              size: DarkButtonSize.Large,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExplorePageViewModel>.reactive(
      // TODO Base filter params
      viewModelBuilder: () => ExplorePageViewModel(args.title, args.sections),
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                    _header(context, model),
                  ] +
                  model.sections
                      .map(
                        (ExploreSectionArguments section) =>
                            ExploreSectionWidget(section),
                      )
                      .toList(),
            ),
          ),
        );
      },
    );
  }
}
