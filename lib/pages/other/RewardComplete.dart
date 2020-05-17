import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';

import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/pages/Tabs.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/routes/customRoute.dart';

class RewardCompletePage extends StatelessWidget {

  final ViewModel model;
  final List<Reward> completedRewards;

  RewardCompletePage( this.model, this.completedRewards );

  @override
  Widget build(BuildContext context) {
    int length = completedRewards.length;
    return Scaffold(
          body:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                PageTitle('Congratulation'),
                //Padding(
                //  padding: EdgeInsets.all(40),
                //  child:
                //    Image(image: AssetImage('assets/imgs/partyPopperEmoji.png'), width: MediaQuery.of(context).size.width * 0.4,),
                //),
                //Padding(
                //  padding: EdgeInsets.all(30),
                //  child: Text('You have slected the following campaigns', style: Theme.of(context).primaryTextTheme.headline, textAlign: TextAlign.center,),
                //), 
                Expanded(
                  child: ListView.builder(
                      itemCount: length + 3,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Container(
                              height: MediaQuery.of(context).size.width * 0.3 ,
                              child: Image(image: AssetImage('assets/imgs/partyPopperEmoji.png'),),
                          );
                        } 
                        if (index == 1) {
                          return Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                                length != 1 ? 'You just completed ${length} achievements!' : 'You completed an achievement', 
                                style: Theme.of(context).primaryTextTheme.headline, textAlign: TextAlign.center,),
                          ); 
                        }
                        if (index == length + 2) {
                          return Container(height: 150,);
                        } 
                        else {
                          return 
                            Padding(
                              padding: EdgeInsets.all(20), 
                              child: Text(
                                completedRewards[index -2].getTitle(),
                              ),
                           );
                        }
                      },
                    ),     
                ),
              ], 
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                   padding: EdgeInsets.only(bottom: 10),
                   child: 
                    DarkButton(
                      'Share with Friends',
                      onPressed: () {
                        String campaingText = '';
                        for (var i = 0; i < completedRewards.length; i++) {
                          campaingText = campaingText + completedRewards[i].getTitle();
                          if (i == completedRewards.length - 2) {
                            campaingText = campaingText + ' and '; 
                          } 
                          else if (i == completedRewards.length - 1) {
                            if (i == 0) {
                              campaingText = campaingText + ' achievement';
                            }
                            else {
                              campaingText = campaingText + ' achievements';
                            }
                          }
                          else {
                            campaingText = campaingText + ', '; 
                          }
                        }
                        Share.share('I just completed the ${campaingText} on now-U. Check them out at https://now-u.com');
                      },
                    ),
                ),
                Padding(
                   padding: EdgeInsets.only(bottom: 20),
                   child: 
                    DarkButton(
                      'Get Started!',
                      onPressed: () {
                        Navigator.push(
                          context, 
                          //CustomRoute(builder: (context) => App(currentIndex: 1,))
                          CustomRoute(builder: (context) => TabsPage(currentPage: TabPage.Home))
                        );
                      },
                    ),
                ),
              ],     
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
  }
}
