import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/main.dart';

import 'package:app/pages/profile/profilePages/FAQPage.dart';
import 'package:app/pages/profile/profilePages/ProfilePage.dart';
import 'package:app/pages/profile/profilePages/PartnersPage.dart';
import 'package:app/pages/Tabs.dart';


class Routes {
  static final intro = "intro";
  static final login = "login";

  static const profile = "profile";
  static const faq = "faq";
  static const parteners = "parteners";

  // Tab View Routes
  static const home = "home";
  static const campaign = "campaign";
//  static final authEmailSent = "authEmailSent";
}

Function initRoutes =
  (RouteSettings settings) {
    switch (settings.name) {
      case Routes.profile: {
        return CustomRoute(
          builder: (context) => ProfilePage()
        );
      }
      case Routes.faq: {
        return CustomRoute(
          builder: (context) => FAQPage()
        );
      }
      case Routes.parteners: {
        return CustomRoute(
          builder: (context) => PartnersPage()
        );
      }
      case Routes.home: {
        return CustomRoute(
          builder: (context) => TabsPage(currentPage: TabPage.Home)
        );
      }
      case Routes.campaign: {
        return CustomRoute(
          builder: (context) => TabsPage(currentPage: TabPage.Campaigns)
        );
      }
      // TODO add a 404 page
      default: {
        return CustomRoute(
          builder: (context) => MyHomePage(3)
        );
      }
    }
  };
