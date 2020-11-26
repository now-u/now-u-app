import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/icons/customIcons.dart';

import 'package:app/assets/components/customTile.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/location_service.dart';

import 'package:app/pages/more/ProfileTile.dart';
import 'package:app/routes.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/base_model.dart';

final profileTiles = <Map>[
  // Profile disabled for v1
  //{
  //  'profileTile':
  //      ProfileTile("Profile", FontAwesomeIcons.solidUserCircle),
  //  'page': Routes.profile,
  //},
  {'sectionHeading': "The app"},
  {
    'profileTile': ProfileTile("About Us",CustomIcons.ic_faq),
    'link': "https://now-u.com/aboutus",
  },
  {
    'profileTile': ProfileTile("Our partners", CustomIcons.ic_partners),
    'page': Routes.parteners,
  },
  {
    'profileTile': ProfileTile("FAQ", CustomIcons.ic_faq),
    'page': Routes.faq,
  },
  {'sectionHeading': "Feedback"},
  {
    'profileTile':
        ProfileTile("Give past campaign feedback", CustomIcons.ic_feedback),
    'link':
        "https://docs.google.com/forms/d/e/1FAIpQLScg9a8pdP6P7GDKfyOCcJkU_i0C1m84T-M4muEUjfo8TmCSkw/viewform",
  },
  {
    'profileTile':
        ProfileTile("Propose a campaign", CustomIcons.ic_suggestcamp),
    'link':
        "https://docs.google.com/forms/d/e/1FAIpQLSfPKOVlzOOV2Bsb1zcdECCuZfjHAlrX6ZZMuK1Kv8eqF85hIA/viewform",
  },
  {
    'profileTile':
        ProfileTile("Give feedback on the app", CustomIcons.ic_feedback),
    'link':
        "https://docs.google.com/forms/d/e/1FAIpQLSflMOarmyXRv7DRbDQPWRayCpE5X4d8afOpQ1hjXfdvzbnzQQ/viewform",
  },
  {
    'profileTile':
        ProfileTile("Rate us on the app store", CustomIcons.ic_rateus),
    'link': Platform.isIOS
        ? "https://apps.apple.com/us/app/now-u/id1516126639"
        : "https://play.google.com/store/apps/details?id=com.nowu.app",
    'external': true
    //'function': () {StoreRedirect.redirect();}
  },
  {
    'profileTile': ProfileTile("Send us a message", CustomIcons.ic_social_fb),
    'link': "http://m.me/nowufb",
    'external': true
  },
  {
    'profileTile': ProfileTile("Send us an email", CustomIcons.ic_email),
    'link': "mailto:hello@now-.com?subject=Hi",
    'external': true
  },
  {'sectionHeading': "Legal"},
  {
    'profileTile': ProfileTile("Terms & conditions", CustomIcons.ic_tc),
    'link': "https://share.now-u.com/legal/now-u_users_Ts&Cs.pdf",
    'external': true
  },
  {
    'profileTile': ProfileTile("Privacy policy", CustomIcons.ic_privacy),
    'link': "https://share.now-u.com/legal/now-u_privacy_policy.pdf",
    'external': true
  },
];
///The More page ![More Page](https://i.ibb.co/xDHyMPj/slack.png)
///
/// This Widget takes in the [profileTiles] and goes over it
/// checking if the elements inside it is either sectionHeading
/// or [ProfileTile]
class Profile extends StatelessWidget {
  
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
      viewModelBuilder: () => BaseModel(),
      builder: (context, model, child) {
        return Scaffold(
            body: Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 45),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "More",
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: profileTiles.length,
                        itemBuilder: (context, index) {
                          if (profileTiles[index]["sectionHeading"] != null) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    left: 20,
                                    top: index == 0 ? 0 : 25,
                                    bottom: 5),
                                child: Text(
                                  profileTiles[index]["sectionHeading"],
                                  style: textStyleFrom(Theme.of(context)
                                      .primaryTextTheme
                                      .headline4),
                                ));
                          } else {
                            return GestureDetector(
                              onTap: () {
                                if (profileTiles[index]["page"] != null) {
                                  Navigator.pushNamed(
                                      context, profileTiles[index]["page"]);
                                } else if (profileTiles[index]["link"] !=
                                    null) {
                                  _navigationService.launchLink(
                                      profileTiles[index]["link"],
                                      isExternal: profileTiles[index]
                                              ['external'] ??
                                          false);
                                } else if (profileTiles[index]["function"] !=
                                    null) {
                                  profileTiles[index]["function"]();
                                }
                              },
                              child: profileTiles[index]["profileTile"],
                            );
                          }
                        }),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SocialButton(
                          icon: FontAwesomeIcons.instagram,
                          link: "https://www.instagram.com/now_u_app/",
                        ),
                        SocialButton(
                          icon: FontAwesomeIcons.facebookF,
                          link: "https://www.facebook.com/nowufb",
                        ),
                        SocialButton(
                          icon: FontAwesomeIcons.twitter,
                          link: "https://twitter.com/now_u_app",
                        )
                      ],
                    ),
                    SizedBox(height: 20),

                    // Dev Tools
                    model.currentUser.isStagingUser()
                      ? Column(
                          children: [
                            GestureDetector(
                              child: ProfileTile("Dev Tools", FontAwesomeIcons.code),
                              onTap: () {
                                //model.logout();
                                //model.api.toggleStagingApi();
                                //viewModel.onUpdateCampaings();
                              }
                            ),
                            GestureDetector(
                              child: ProfileTile("Log out", FontAwesomeIcons.code),
                              onTap: () {
                                model.logout();
                              }
                            ),
                            GestureDetector(
                              child: ProfileTile("Navigate test", FontAwesomeIcons.code),
                              onTap: () {
                                _navigationService.launchLink("internal:learningTopic&id=-1");
                              }
                            ),
                            GestureDetector(
                              child: ProfileTile("Get Location", FontAwesomeIcons.code),
                              onTap: () {
                                _locationService.getCurrentAddress();
                              }
                            ),
                          ]
                        )
                      : Container()
                  ],
                )));
      },
    );
  }
}

class SocialButton extends StatelessWidget {
  final double size = 50;
  final IconData icon;
  final String link;

  SocialButton({
    this.icon,
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          launch(link);
        },
        child: CustomTile(
            borderRadius: size / 2,
            child: Container(
              height: size,
              width: size,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size / 2),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )));
  }
}
