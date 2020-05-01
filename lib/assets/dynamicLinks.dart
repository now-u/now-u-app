import 'package:flutter/material.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/assets/routes/customRoute.dart';

import 'package:app/pages/Tabs.dart';
import 'package:app/pages/campaign/CampaignPage.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';


// Dynamic Links setup
Future <Uri> createDynamicLink(bool short) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: "https://nowu.page.link",
    link: Uri.parse("https://now-u."),
    androidParameters: AndroidParameters(
      packageName: "com.nowu.app",
      minimumVersion: 0,
    ),
    //TODO IOS needs fixing
    iosParameters: IosParameters(
      bundleId: "com.google.FirebaseCppDynamicLinksTestApp.dev",
      minimumVersion: '0',
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: "now-u campaigns",
      description: "Each month now-u offers 3 campaings to tackle relevant issues. These campaings provide easy actions for the user to complete in order to empower them to drive socail change.",
      imageUrl: Uri.parse("https://images.unsplash.com/photo-1491382825904-a4c6dca98e8c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
    )
  );
  Uri url;
  if (short) {
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    print(shortLink.toString());
    url = shortLink.shortUrl;
  }
  else {
    url = await parameters.buildUrl();
  }
  return url;
}


int initDynamicLinks() {
  print("INITING DYNAMIC LINKS");
  FirebaseDynamicLinks.instance.getInitialLink().then(
    (data) {
      final Uri deepLink = data?.link;
      if (deepLink!=null) {
        print("DEEP LINK PATH");
        print(deepLink.path);
        switch (deepLink.path) {
          case "campaigns": {
            return 0;
          } 
          default: {
            return 0;
          }
        }
      }
      return 1;
    }
  );
}
