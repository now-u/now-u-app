import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/popUpMenuItem.dart' as customPopup;

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double CAMPAIGN_SELECT_HEIGHT = 120;
final _controller = PageController(
  initialPage: 0,
  viewportFraction: 0.93,
);
final _animatedList = GlobalKey<AnimatedListState>();

const curve = Curves.ease;
const duration = Duration(milliseconds: 500);

class ActionPage extends StatefulWidget {
  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  Campaign campaign;
  List<CampaignAction> actions;
  List<String> actionFilters;

  @override
  initState() {
    actions = []; 
    actionFilters = [];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel viewModel) {
            campaign = viewModel.campaigns.getActiveCampaigns()[0];
            actions.addAll(campaign.getActions());
            return 
              Scaffold(
                backgroundColor: colorFrom(
                  Theme.of(context).primaryColor,
                  opacity: 0.05,
                ),
                appBar: CustomAppBar(
                  text: "Actions",
                  hasBackButton: false,
                  context: context,
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: customPopup.PopupMenuButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.filter_list,
                          color: Theme.of(context).primaryColor,
                        ),
                        itemBuilder: (BuildContext context) {
                          return buildListPopupItems(context, viewModel);
                        },
                      )
                    ),
                  ],
                ),
                body: Column(
                  children: <Widget>[
                    SizedBox(height: 15),
                    // Campaign selection widget
                    Container(
                      height: CAMPAIGN_SELECT_HEIGHT,
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: viewModel.campaigns.getActiveCampaigns().length,
                        itemBuilder: (BuildContext context, int index) {
                          return CampaignSelectionTile(viewModel.campaigns.getActiveCampaigns()[index]);
                        },
                        onPageChanged: (int pageIndex) {
                          setState(() {
                            campaign = viewModel.campaigns.getActiveCampaigns()[pageIndex];
                            actions = [];
                            actions.addAll(campaign.getActions());
                          });
                        }
                      )
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: viewModel.campaigns.getActiveCampaigns().length,
                      effect: WormEffect(
                        dotColor: Color.fromRGBO(150, 153, 168, 1),
                        activeDotColor: Colors.orange,
                        spacing: 10.0,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),

                    SizedBox(height: 15,),

                    // Actions List
                    Expanded(
                      child: AnimatedList(
                        key: _animatedList,
                        initialItemCount: actions.length,
                        itemBuilder: (BuildContext context, int index, animation) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: ActionSelectionItem(
                              outerHpadding: 10,
                              campaign: campaign,
                              action: actions[index],
                              backgroundColor: Colors.white,
                            )
                          ); 
                        }
                      )
                    )

                  ],
                )
              );
      }
    );
  }
}

class CampaignSelectionTile extends StatelessWidget {
  final Campaign campaign;
  CampaignSelectionTile (this.campaign);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: <Widget> [
            Stack(
              children: <Widget>[
                Container(
                  height: CAMPAIGN_SELECT_HEIGHT,
                  decoration: BoxDecoration(
                    image: DecorationImage( 
                      image: NetworkImage(campaign.getHeaderImage()), 
                      fit: BoxFit.cover, 
                    ),
                  )
                ),
                Container(
                  height: CAMPAIGN_SELECT_HEIGHT,
                  color: colorFrom(
                    Colors.black,
                    opacity: 0.3,
                  )
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  campaign.getTitle(),
                  textAlign: TextAlign.center,
                  style: textStyleFrom(
                    Theme.of(context).primaryTextTheme.headline4,
                    color: Colors.white,
                  )
                )
              ),
            )
          ]
        )
      )
    );
  }
}

enum CampaignSelectionChevronDirection {
  Right,
  Left
}

class CampaignSelectionChevron extends StatelessWidget {
  final CampaignSelectionChevronDirection direction;
   
  CampaignSelectionChevron(this.direction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        direction == CampaignSelectionChevronDirection.Left ? _controller.previousPage(curve: curve, duration: duration) : _controller.nextPage(curve: curve, duration: duration);
      },
      child: Container(
        height: 80,
        width: 60,
        child: Center(
          child: Icon(
              direction == CampaignSelectionChevronDirection.Left ? Icons.chevron_left : Icons.chevron_right,
              color: Colors.orange,
              size: 40,
          ),
        )
      )
    );
  }
}

customPopup.PopupMenuItem buildPopupMenuHeader(
      BuildContext context,
      String text,
    ) {
    return customPopup.PopupMenuItem(
      //value: "hi",
      child: Container(
        height: 40.0,
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Text(
                text,
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.headline4,
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      )
    );
}

customPopup.PopupMenuItem buildPopupMenuItem({
      @required BuildContext context,
      @required String text,
    }) {
    return customPopup.PopupMenuItem(
      child: Container(
        height: 40.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Checkbox(
              onChanged: (bool) {print("Checked");},
              value: false,
            ),
            Container(
              color: Colors.white,
              child: Text(
                "Joined campaigns",
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.headline4,
                  color: Colors.black,
                ),
              ),
            )
          ],
        )
      )
    );
}

List<customPopup.PopupMenuItem> buildListPopupItems(BuildContext context, ViewModel viewModel) {
  List<customPopup.PopupMenuItem> items = [
    buildPopupMenuHeader(context, "Joined campaigns"),
  ];
  List<customPopup.PopupMenuItem> campaignSelectors = viewModel.campaigns.getSelectedActiveCampaigns(viewModel.userModel.user).map((c) => buildPopupMenuItem(context: context, text: c.getTitle())).toList();
  print("campaign selectors are");
  print(campaignSelectors);
  items.addAll(campaignSelectors);
  items.add(
    buildPopupMenuHeader(context, "Categories"),
  );
  items.add(
    buildPopupMenuHeader(context, "Time"),
  );
  return items;
} 

