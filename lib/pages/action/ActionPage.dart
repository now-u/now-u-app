import 'package:app/assets/components/customAppBar.dart';
import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/selectionItem.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double CAMPAIGN_SELECT_HEIGHT = 120;
final _controller = PageController(
  initialPage: 0,
  viewportFraction: 1,
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
                appBar: CustomAppBar(
                  text: "Actions",
                  hasBackButton: false,
                  context: context,
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: PopupMenuButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.filter_list,
                          color: Theme.of(context).primaryColor,
                        ),
                        itemBuilder: (BuildContext context) {
                          return 
                            [
                              buildPopupMenuHeader(context),
                              buildPopupMenuHeader(context),
                            ];
                        },
                      )
                    ),
                  ],
                ),
                body: Column(
                  children: <Widget>[
                    // Campaign selection widget
                    Container(
                      height: CAMPAIGN_SELECT_HEIGHT,
                      child: Stack(
                        children: <Widget>[
                          PageView.builder(
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
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CampaignSelectionChevron(CampaignSelectionChevronDirection.Left),
                                CampaignSelectionChevron(CampaignSelectionChevronDirection.Right),
                              ],
                            ),
                          )
                        ],
                      )
                    ),

                    // Actions List
                    Expanded(
                      child: AnimatedList(
                        key: _animatedList,
                        initialItemCount: actions.length,
                        itemBuilder: (BuildContext context, int index, animation) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ActionSelectionItem(
                              campaign: campaign,
                              action: actions[index],
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
    return
      Stack(
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

PopupMenuItem buildPopupMenuHeader(
      BuildContext context,
    ) {
    return PopupMenuItem(
      textStyle: TextStyle(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      //value: "hi",
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Text(
          "Joined campaigns",
          style: textStyleFrom(
            Theme.of(context).primaryTextTheme.headline4,
            color: Colors.white,
          ),
        ),
      )
    );
}
