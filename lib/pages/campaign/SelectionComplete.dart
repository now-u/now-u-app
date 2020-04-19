import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:app/models/Campaign.dart';

import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/main.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/routes/customRoute.dart';

class SelectionComplete extends StatelessWidget {

  List<Campaign> _selectedCamapings;
  SelectionComplete( selectedCampaings ) {
    _selectedCamapings = selectedCampaings;   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                PageTitle("Congratulation"),
                //Padding(
                //  padding: EdgeInsets.all(40),
                //  child:
                //    Image(image: AssetImage('assets/imgs/partyPopperEmoji.png'), width: MediaQuery.of(context).size.width * 0.4,),
                //),
                //Padding(
                //  padding: EdgeInsets.all(30),
                //  child: Text("You have slected the following campaigns", style: Theme.of(context).primaryTextTheme.headline, textAlign: TextAlign.center,),
                //), 
                Expanded(
                  child: ListView.builder(
                      itemCount: _selectedCamapings.length + 3,
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
                            child: Text("You have slected the following campaigns", style: Theme.of(context).primaryTextTheme.headline, textAlign: TextAlign.center,),
                          ); 
                        }
                        if (index == _selectedCamapings.length + 2) {
                          return Container(height: 150,);
                        } 
                        else {
                          return 
                            Padding(
                              padding: EdgeInsets.all(20), 
                              child: CampaignTile(
                                _selectedCamapings[index -2]
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
                      "Share with Friends",
                      onPressed: () {
                        String campaingText = '';
                        for (var i = 0; i < _selectedCamapings.length; i++) {
                          campaingText = campaingText + _selectedCamapings[i].getTitle();
                          if (i == _selectedCamapings.length - 2) {
                            campaingText = campaingText + ' and '; 
                          } 
                          else if (i == _selectedCamapings.length - 1) {
                            if (i == 0) {
                              campaingText = campaingText + ' campaing';
                            }
                            else {
                              campaingText = campaingText + ' campaings';
                            }
                          }
                          else {
                            campaingText = campaingText + ', '; 
                          }
                        }
                        Share.share('I just started the ${campaingText} on now-U. Check them out at https://now-u.com');
                      },
                    ),
                ),
                Padding(
                   padding: EdgeInsets.only(bottom: 20),
                   child: 
                    DarkButton(
                      "Get Started!",
                      onPressed: () {
                        Navigator.push(
                          context, 
                          CustomRoute(builder: (context) => App(currentIndex: 1,))
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
