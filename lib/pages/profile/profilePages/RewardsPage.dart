import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';

import 'package:app/models/Reward.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Action.dart';

const double ICON_PADDING = 40;
const double ITEM_HORIZONTAL = 30;
const double ITEM_VERTICAL = 30;

//var _rewards = <Reward>[
//  Reward(id: 1, title: "Shower Rail", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
//  Reward(id: 1, title: "One way tickets to Mozambique", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
//  Reward(id: 1, title: "James Elgar", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false),
//  Reward(id: 1, title: "22% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
//  Reward(id: 1, title: "£5 amazon voucher", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
//  Reward(id: 1, title: "A car", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
//  Reward(id: 1, title: "24% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
//];

class RewardsPage extends StatelessWidget {
  GestureTapCallback goBack;
  ViewModel model;

  RewardsPage(this.goBack, this.model) {
  }
  @override
  Widget build(BuildContext context) {
  var _rewards = <Reward>[
    Reward(id: 1, title: "Select 3 Campaigns", successNumber: 3, type: RewardType.SelectInOneMonthCampaignsNumber),
    Reward(id: 2, title: "Complete first action", successNumber: 1, type: RewardType.CompletedActionsNumber),
    Reward(id: 3, title: "Sign 5 petitons", successNumber: 5, type: RewardType.CompletedTypedActionsNumber, actionType: CampaignActionType.Petition),
  ];
    return Column(
        children: <Widget>[
          PageTitle("Rewards", hasBackButton: true, onClickBackButton: goBack,),
          Text("You have completed x campaigns",
            style: Theme.of(context).primaryTextTheme.body1),
          Text("Thankyou",
            style: Theme.of(context).primaryTextTheme.body1),
          Expanded(
            child:
            ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: _rewards.length,
              itemBuilder: (context, index) =>
                  GestureDetector(
                    // TODO Offer more info page
                    onTap: () {},
                    child: RewardTile(_rewards[index], model),
                  ),
            ),
          ),
          DarkButton("See Highlights",
            onPressed: (){})
        ]
    );
  }
}

class RewardTile extends StatelessWidget {
  Reward reward;
  ViewModel model;

  RewardTile(this.reward, this.model);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: EdgeInsets.fromLTRB(ITEM_HORIZONTAL, ITEM_VERTICAL, ITEM_HORIZONTAL, ITEM_VERTICAL),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: ICON_PADDING),
                  child: Icon(FontAwesomeIcons.ribbon, size: 50,)
              ),
              Text(reward.getTitle(), style: Theme.of(context).primaryTextTheme.body1),
              Text(model.user.getRewardProgress(reward).toString(), style: Theme.of(context).primaryTextTheme.body1),
            ],
          ),
        )
    );
  }
}
