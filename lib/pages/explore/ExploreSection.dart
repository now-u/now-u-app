import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/assets/constants.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/models/article.dart';
import 'package:app/models/Learning.dart';
import 'package:app/pages/explore/ExplorePage.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:app/assets/components/selectionPill.dart';

class ExploreFilterSelectionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  ExploreFilterSelectionItem(
      {required BaseExploreFilterOption item, required this.onPressed})
      : this.text = item.displayName,
        this.isSelected = item.isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? CustomColors.black1 : CustomColors.greyLight2,
            borderRadius: BorderRadius.all(Radius.circular(24))),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? CustomColors.white : CustomColors.black2,
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreSectionWidget extends StatelessWidget {
  final ExploreSection data;
  final Function(ExplorePage page) changePage;
  final Function(BaseExploreFilterOption option) toggleFilterOption;

  ExploreSectionWidget({
    required this.data,
    required this.toggleFilterOption,
    required this.changePage,
  });

  ExploreSectionWidget.fromModel(
      ExploreSection section, ExploreViewModelMixin model)
      : data = section,
        changePage = ((_) {}),
        toggleFilterOption = ((BaseExploreFilterOption option) =>
            model.toggleFilterOption(section, option));

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      // Section header
      Column(
        children: [
          // Text header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                GestureDetector(
                  onTap:
                      data.link != null ? () => changePage(data.link!) : () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: Theme.of(context).primaryTextTheme.headline3,
                        textAlign: TextAlign.left,
                      ),
                      if (data.link != null) Icon(Icons.chevron_right, size: 30)
                    ],
                  ),
                ),
                if (data.description != null)
                  Text(
                    data.description!,
                    style: Theme.of(context).primaryTextTheme.headline4,
                    textAlign: TextAlign.left,
                  ),
              ],
            ),
          ),
          SizedBox(height: 2),
          if (data.filter != null &&
              data.filter!.state == ExploreFilterState.Loaded)
            Container(
              height: 40,
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 8, top: 6),
                scrollDirection: Axis.horizontal,
                itemCount: data.filter!.options.length,
                itemBuilder: (context, index) {
                  BaseExploreFilterOption option = data.filter!.options[index];
                  return Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                        left: index == 0 ? horizontalPadding : 0,
                      ),
                      child: ExploreFilterSelectionItem(
                        item: option,
                        onPressed: () => toggleFilterOption(option),
                      ));
                },
              ),
            ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(
            bottom: CustomPaddingSize.normal, top: CustomPaddingSize.small),
        child: Container(
          height: data.tileHeight + tileShadowBlurRadius,
          child: data.state == ExploreSectionState.Loading
              ? const Center(child: CircularProgressIndicator())
              : data.state == ExploreSectionState.Errored || data.tiles == null
                  // TODO handle error here
                  ? Container(color: Colors.red)
                  : data.tiles!.length == 0
                      ? Center(child: Text("No results"))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.tiles!.length,
                          itemBuilder: (context, index) => Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 8,
                                left: index == 0 ? horizontalPadding : 0,
                                bottom: tileShadowBlurRadius,
                              ),
                              child: data.renderTile(data.tiles![index]),
                            ),
                          ),
                        ),
        ),
      ),
    ]);
  }
}
