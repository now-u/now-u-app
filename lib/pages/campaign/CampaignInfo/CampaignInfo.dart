import 'package:app/assets/components/darkButton.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/SDG.dart';

import 'package:app/services/api.dart';
import 'package:app/locator.dart';
import 'package:app/routes.dart';

import 'package:app/assets/icons/customIcons.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:app/assets/components/organisationTile.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/routes/customLaunch.dart';

const double H_PADDING = 20;
final Api api = locator<Api>();

class CampaignInfo extends StatelessWidget {
  final Campaign campaign;
  final int campaignId;

  CampaignInfo({this.campaign, this.campaignId})
      : assert(campaign != null || campaignId != null);
  
  @override
  Widget build(BuildContext context) {
    if (campaign != null) {
      return CampaignInfoBody(campaign);
    }
    return FutureBuilder(
      future: api.getCampaign(campaignId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return CampaignInfoBody(snapshot.data);
      },
    );
  }
}

class CampaignInfoBody extends StatelessWidget {
  final Campaign _campaign;

  CampaignInfoBody(this._campaign);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          // Header
          Container(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_campaign.getHeaderImage()),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: colorFrom(
                  Colors.black,
                  opacity: 0.5,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      PageHeader(
                        title: _campaign.getTitle(),
                        textColor: Colors.white,
                        backButton: true,
                        backButtonText: "",
                        maxLines: 4,
                        fontSize: Theme.of(context).primaryTextTheme.headline3.fontSize,
                        extraInnerPadding: 20,
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),

          // Body
          Container(
            color: Color.fromRGBO(247, 248, 252, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomTile(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Text("See what you can do to support this cause today!", 
                              style: textStyleFrom(Theme.of(context).primaryTextTheme.headline4),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15,),
                            DarkButton("Take action", onPressed: (){
                              if (_campaign.isPast()) {
                                Navigator.of(context).pushNamed(Routes.pastCampaignActionPage, arguments: _campaign);
                              }
                              else {
                                Navigator.of(context).pushNamed(Routes.actions);
                              }
                            })
                          ],
                        ),
                      )
                    ),
                  ),

                  SizedBox(height: 25),

                  // About
                  Text(
                    "About",
                    style: Theme.of(context).primaryTextTheme.headline3,
                  ),
         
                  SizedBox(height: 15),

                  // Stats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CampaignStat(text: "${_campaign.getNumberOfCampaigners()} people have joined", icon: CustomIcons.ic_partners),
                      //CampaignStat(text: "Actions completed"),,
                      CampaignStat(text: "Global reach", icon: Icons.people,),
                    ],
                  ),
                  
                  SizedBox(height: 25),

                  // Buttons
                  Column(
                    children: [
                      CampaignButton(
                        text: "Watch the video", 
                        icon: CustomIcons.ic_video, 
                        onTap: () {
                          //Navigator.of(context).pushNamed(Routes.videoPlayer);
                        }
                      ),
                      CampaignButton(
                        text: "Read summary", 
                        icon: CustomIcons.ic_news, 
                        onTap: () {
                        }
                      ),
                      CampaignButton(
                        text: "Go to learning hub", 
                        icon: CustomIcons.ic_learning, 
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.learningSingle, arguments: _campaign.getId());
                        }
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // Share 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextButton(
                        "Share this campaign",
                        onClick: () async {
                          String text = await _campaign.getShareText();
                          Share.share(text);
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 30),

                ]
              ),
            ),
          ),

          // Goals
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 35,),
                  
                  Text(
                    "Goals",
                    style: Theme.of(context).primaryTextTheme.headline3,
                  ),
                  
                  SizedBox(height: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _campaign.getKeyAims().map((aim) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(CustomIcons.ic_bullseye),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  aim,
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15)
                        ]
                      );
                    }).toList()
                  ),
                  
                  SizedBox(height: 20),
                ],
              ),
            )
          ),

          // Partners
          _campaign.getGeneralPartners().length == 0 ? Container() :
          Container(
            color: Color.fromRGBO(247,248,252,1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 35, horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Campaign partners",
                    style: Theme.of(context).primaryTextTheme.headline3,
                  ),
                  SizedBox(height: 20,),
                  Wrap( 
                    children: getOrganistaionTiles(_campaign.getGeneralPartners(), context),
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                  ),
                  SizedBox(height: 30,),
                ],
              )
            )
          ),

          // SDGs
          SizedBox(height: 30),

          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _campaign.getSDGs().length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: SDGSelectionItem(_campaign.getSDGs()[index]),
                );
              },
              // )
            )
          ),
  
          SizedBox(height: 30),

          // Find out more - SDGs
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Find out more at:",
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextButton(
                    "sustainabledevelopment.un.org",
                    onClick: () {customLaunch(context, "https://sustainabledevelopment.un.org");},
                    fontSize: Theme.of(context).primaryTextTheme.bodyText1.fontSize,
                  ),
                ]
              )
            ],
          ),

          SizedBox(height: 50),
        ],
      )
    );
  }
}

class CampaignStat extends StatelessWidget {
  final String text;
  final IconData icon;

  CampaignStat({
    @required this.text,
    @required this.icon,
  });

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryTextTheme.bodyText1.color,
          ),
          SizedBox(width: 10,),
          Text(
            text
          ) 
        ],
      ),
    );
  }
}

class CampaignButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  CampaignButton({
    @required this.text,
    @required this.icon,
    @required this.onTap,
  });

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: CustomTile(
        onClick: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Icon(
                icon, 
                color: Theme.of(context).primaryTextTheme.bodyText1.color,
              ),
              SizedBox(width: 14,),
              Text(
                text,
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.headline5
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class OrganisationReel extends StatelessWidget {
  final List<Organisation> organisations;
  final YoutubePlayerController controller;
  OrganisationReel(this.organisations, this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        //child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: organisations.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: OrganisationTile(
                organisations[index],
                extraOnTap: () {
                  controller.pause();
                },
              ),
            );
          },
          // )
        ));
  }
}

class SDGSelectionItem extends StatelessWidget {
  final SDG sdg;
  SDGSelectionItem(this.sdg);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          customLaunch(context, sdg.getLink());
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 70,
              width: 70,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Image.asset(
                  sdg.getImage(),
                ),
              ),
            ),
            SizedBox(width: 13),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "This campaign is working towards the United Nations ",
                      style: Theme.of(context).primaryTextTheme.bodyText1
                    ),
                    TextSpan(
                      text: "Sustainable Development Goal ${sdg.getNumber()}.",
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.bodyText1,
                        fontWeight: FontWeight.w600,
                      )
                    ),
                  ]
                ),
              ),
            ),
          ],
        ));
  }
}

List<Widget> getOrganistaionTiles(List<Organisation> organisations, BuildContext context) {
  List<Widget> orgTiles = [];
  for(final org in organisations) {
    orgTiles.add(
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.organisationPage, arguments: org);
        },
        child: CustomTile(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Container(
              height: 30,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(org.getLogoLink()),
                  SizedBox(width: 5,),
                  Text(
                    org.getName(),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
  return orgTiles;
}

class SectionTitle extends StatelessWidget {
  final String text;
  final double hPadding;

  SectionTitle(
    this.text, 
    {
      this.hPadding,
    }
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding ?? 0, vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).primaryTextTheme.headline4,
      ),
    );
  }
}
