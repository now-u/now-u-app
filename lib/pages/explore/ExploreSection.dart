import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/card.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/pages/explore/ExplorePage.dart';
import 'package:nowu/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';

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
  final Function(ExplorePageArguments page) changePage;
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

  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          GestureDetector(
            onTap: data.args.link != null
                ? () => changePage(data.args.link!)
                : () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data.args.title,
                  style: Theme.of(context).primaryTextTheme.headline3,
                  textAlign: TextAlign.left,
                ),
                if (data.args.link != null) Icon(Icons.chevron_right, size: 30)
              ],
            ),
          ),
          if (data.args.description != null)
            Text(
              data.args.description!,
              style: Theme.of(context).primaryTextTheme.headline4,
              textAlign: TextAlign.left,
            ),
        ],
      ),
    );
  }

  Widget _buildSectionFilters() {
    return Container(
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
    );
  }

  Widget _noTilesFound() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: BaseCard(
        Padding(
          padding: EdgeInsets.all(CustomPaddingSize.normal),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Oops.. No items found",
                    style: lightTheme.textTheme.headlineMedium,
                  ),
                ],
              ),
              SizedBox(height: CustomPaddingSize.small),
              Text(
                "Looks like we don’t have any ‘${data.args.title}’ to recommend right now. Check out our ‘Explore’ page to get involved another way.",
                style: lightTheme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: CustomPaddingSize.small),
              DarkButton(
                "Explore",
                onPressed: () => changePage(home_explore_page),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildTiles(BuildContext context) {
    final sectionHeight = data.tileHeight;

    if (data.state == ExploreSectionState.Loading) {
      return Container(
          height: sectionHeight,
          child: Center(child: CircularProgressIndicator()));
    }
    if (data.state == ExploreSectionState.Errored || data.tiles == null) {
      return Container(color: Colors.red);
    }
    if (data.tiles!.length == 0) {
      return _noTilesFound();
    }
    return Container(
      height: sectionHeight,
      clipBehavior: Clip.none,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: data.tiles!.length,
        itemBuilder: (context, index) => Container(
          clipBehavior: Clip.none,
          child: Padding(
            padding: EdgeInsets.only(
              right: 8,
              left: index == 0 ? horizontalPadding : 0,
            ),
            child: data.renderTile(data.tiles![index]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: data.args.backgroundColor,
        child: Padding(
          padding:
              EdgeInsets.only(top: data.args.backgroundColor != null ? 12 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Section header
              Column(
                children: [
                  // Text header
                  _buildSectionHeader(context),
                  SizedBox(height: 2),
                  if (data.filter != null &&
                      data.filter!.state == ExploreFilterState.Loaded)
                    _buildSectionFilters(),

                  SizedBox(height: CustomPaddingSize.small),
                  _buildTiles(context),
                  SizedBox(height: CustomPaddingSize.normal),
                ],
              ),
            ],
          ),
        ));
  }
}
