import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app/routes.dart';

import 'package:app/pages/news/NewsPage.dart';
import 'package:app/pages/Tabs.dart';
import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/pages/other/InfoPage.dart';
import 'package:intl/intl.dart';
import 'package:app/assets/ClipShadowPath.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/customScrollableSheet.dart';
import 'package:app/assets/components/progress.dart';
import 'package:app/assets/components/viewCampaigns.dart';
import 'package:app/assets/components/smoothPageIndicatorEffect.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

const double BUTTON_PADDING = 10;

final double headerHeight = 250;

class Home extends StatelessWidget {
  final Function changePage;
  Home(this.changePage);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFrom(
        Theme.of(context).primaryColor,
        opacity: 0.05,
      ),
      body: ScrollableSheetPage(
        header: 
              Container(
                height: headerHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).errorColor,
                    ]
                  )
                ),
                child: StoreConnector<AppState, ViewModel>(
                  converter: (Store<AppState> store) => ViewModel.create(store),
                  builder: (BuildContext context, ViewModel viewModel) {
                  return Stack(
                    children: <Widget> [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                   Text(
                                      "Hello\n${viewModel.userModel.user.getName()}",
                                      style: textStyleFrom(
                                        Theme.of(context).primaryTextTheme.headline2,
                                        color: Colors.white,
                                        height: 0.95,
                                      ),
                                    ),
                                    SizedBox(height: 17),
                                    Text(
                                      "Ready to do some good to the world?",
                                      style: textStyleFrom(
                                        Theme.of(context).primaryTextTheme.headline3,
                                        fontSize: 20,
                                        color: Colors.white,
                                        height: 0.95,
                                      )
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Positioned(
                        right: -20,
                        //top: actionsHomeTilePadding,
                        bottom: 10,
                        child: Container(
                          height: 210,
                          child: Image(
                            image: AssetImage('assets/imgs/graphics/ilstr_home_1@3x.png'),
                          )
                        )
                      ),
                    ],
                  );
                }
                ),
              ),
              children: <Widget>[
              
               HomeTitle(
                 "${DateFormat("MMMM").format(DateTime.now())}'s campaigns",
                 subtitle: "Our campaigns are always in partnership with trusted institutions. Here’s the ones for ${DateFormat("MMMM").format(DateTime.now())}:",
                 infoTitle: "My Impact",
                 infoText: "At the end of each campaign you joined, we will ask you to answer a (non mandatory) survey to let us know how much you learnt, if you felt like you made a difference, and your overall thoughts on the campaigns.\n Then you will receive an impact report with infographics for the campaign with a full impact report with all our metrics and learnings.\n We are also working to bring some of these numbers to be displayed in the app soon :)",
               ),

               CampaignCarosel(),

               SizedBox(height: 15),

               Container(
                 color: Color.fromRGBO(255,243,230,1),
                 child: Padding(
                   padding: EdgeInsets.symmetric(vertical: 10),
                   child: Column(
                     children: [
                       HomeTitle(
                         "Take action now!",
                         subtitle: "Find out what you can start doing to support your campaign:",
                       ),
                       Padding(
                         padding: EdgeInsets.all(15),
                         child: DarkButton(
                           "See my Actions",
                           onPressed: () {
                             Navigator.of(context).pushNamed(Routes.actions);
                           },
                         )
                       )
                     ],
                   )
                 )
               ),
              
               SizedBox(height: 10),

               Container(
                 child: Padding(
                   padding: EdgeInsets.all(10),
                   child: Column(
                     children: [
                       Text(
                         "What cause do you want to support next?",
                         style: Theme.of(context).primaryTextTheme.bodyText1,
                       ),

                       Padding(
                         padding: EdgeInsets.all(15),
                         child: DarkButton(
                           "Suggest a campaign",
                           onPressed: () {
                             launch("https://docs.google.com/forms/d/e/1FAIpQLSfPKOVlzOOV2Bsb1zcdECCuZfjHAlrX6ZZMuK1Kv8eqF85hIA/viewform");
                           },
                           inverted: true,
                         ),
                       )
                     ],
                   )
                 ),
               ),

               // Impact Section
               StoreConnector<AppState, ViewModel>(
                 converter: (Store<AppState> store) => ViewModel.create(store),
                 builder: (BuildContext context, ViewModel viewModel) {
                   return Container(
                     child: Padding(
                       padding: EdgeInsets.all(10),
                       child: Column(
                         children: [
                           Stack(
                             children: [
                               //Image.asset(),
                               //BadgeIndicator(),
                               HomeTitle(
                                 "My Impact",
                                 infoTitle: "My Impact",
                                 infoText: "At the end of each campaign you joined, we will ask you to answer a (non mandatory) survey to let us know how much you learnt, if you felt like you made a difference, and your overall thoughts on the campaigns.\n Then you will receive an impact report with infographics for the campaign with a full impact report with all our metrics and learnings.\n We are also working to bring some of these numbers to be displayed in the app soon :)",
                               ),
                             ]
                           ),
                           ImpactTile(
                             viewModel.userModel.user.getSelectedCampaigns().length,
                             "Campaigns Joined"
                           ),
                           SizedBox(height: 10),
                           ImpactTile(
                             viewModel.getActiveCompletedActions().length,
                             "Actions taken"
                           )
                         ],
                       ),
                     ),
                   );
                 }
               )
            ]

      )
    );
  }
}
 
Widget sectionTitle(String t, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(10),
    child:
      Text(t, style: 
        Theme.of(context).primaryTextTheme.headline3,
        textAlign: TextAlign.start,
      ),
  );
}

class HomeActionTile extends StatelessWidget {
  final Function changePage;
  HomeActionTile(this.changePage);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          if (viewModel.getActiveSelectedCampaings().getActions().length == 0) {
            return Container(
              height: 200,
              child: ViewCampaigns(),
            );
          }
          else {
            return Column(
              children: <Widget>[
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: 
                    (BuildContext context, int index) => 
                      ActionSelectionItem(
                        action: viewModel.campaigns.getActiveCampaigns()[index].getActions()[index],
                        campaign: viewModel.campaigns.getActiveCampaigns()[index],
                        outerHpadding: 10,
                        backgroundColor: Colors.white,
                    ),
                ),
                HomeButton(
                  text: "All actions",
                  changePage: changePage,
                  page: TabPage.Actions,
                )
                //ActionItem(user.getFollowUpAction()),
                //TODO Work ou where follow up actions should be
              ]
            );
          }
        }
      )
            
    );
  }
}


class HomeButton extends StatelessWidget {
  final String text;
  final Function changePage;
  final TabPage page;

  HomeButton({
    @required this.text,
    @required this.changePage,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(BUTTON_PADDING),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget> [
            DarkButton(
              text, 
              rightArrow: true,
              onPressed: () {
                changePage(
                  page ?? TabPage.Home
                );
              },
              style: DarkButtonStyles.Small,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDividor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: 2,
      color: Color.fromRGBO(238,238,238, 1),
    );
  }
}

class CampaignCarosel extends StatelessWidget {
  final _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.93,
  );
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Column(
          children: [
            Container(
              height: 280,
              child: PageView.builder(
                  controller: _controller,
                  itemCount: viewModel.campaigns.getActiveCampaigns().length,
                      // If all the active campaigns have been joined
                  //itemCount: viewModel.campaigns.getActiveCampaigns().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CampaignTile(
                        viewModel.campaigns.getActiveCampaigns()[index],
                          // Used to only selected campaigns ==> remeber to change count
                      //viewModel
                      //  .userModel.user
                      //  .filterSelectedCampaigns(viewModel.campaigns
                      //      .getActiveCampaigns())[index],
                        hOuterPadding: 4,
                      ),
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: viewModel.campaigns.getActiveCampaigns().length,
                effect: customSmoothPageInducatorEffect,
              )
          ]
        );
      }
    );
  }
}

class HomeTitle extends StatelessWidget {

  final String title;
  final String subtitle;
  final String infoTitle;
  final String infoText;


  HomeTitle(
    this.title,
    {
      this.subtitle,
      this.infoText,
      this.infoTitle,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
                SizedBox(width: 7,),

                infoText == null ? Container() :
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.info,
                      arguments: InfoPageArgumnets(
                        title: infoTitle, 
                        body: infoText,
                      ),
                    );
                  },
                  child: Icon(
                    FontAwesomeIcons.questionCircle,
                    color: Theme.of(context).primaryColor,
                  ),
                ) 
              ]
            )
          ),

          subtitle == null ? Container() :
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              subtitle,
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
          
        ],
      ), 
    );
  }
}

class ImpactTile extends StatelessWidget {
  final int number;
  final String text;
  ImpactTile(this.number, this.text);
  @override
  Widget build(BuildContext context) {
    return CustomTile(
      child: Row(
        children: [
          SizedBox(width: 20),
          Text(
            number.toString(),
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: Theme.of(context).primaryTextTheme.headline4,
          ),

        ],
      ),
    );
  }
}
