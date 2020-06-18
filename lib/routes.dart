import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/main.dart';

import 'package:app/pages/profile/profilePages/FAQPage.dart';
import 'package:app/pages/profile/profilePages/ProfilePage.dart';
import 'package:app/pages/profile/profilePages/PartnersPage.dart';
import 'package:app/pages/intro/IntroPage.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/pages/other/BetaPage.dart';
import 'package:app/pages/Tabs.dart';
import 'package:app/pages/campaign/LearningCentre/LearningCentreAllPage.dart';

class Routes {
  // Intro
  static const intro = "intro";
  static const login = "login";

  // Tab View Routes
  static const campaign = "campaign";
  static const actions = "actions";
  static const home = "home";

  // Other
  static const profile = "profile";
  static const faq = "faq";
  static const parteners = "parteners";

  // Learning
  static const learningAll = "learning";

  // Beta only
  static const beta = "beta";
//  static final authEmailSent = "authEmailSent";
}

Function initRoutes = (RouteSettings settings) {
  switch (settings.name) {

    // Into
    case Routes.login:
      {
        return CustomRoute(builder: (context) => LoginPage());
      }
    case Routes.intro:
      {
        return CustomRoute(builder: (context) => IntroPage());
      }

    case Routes.profile:
      {
        return CustomRoute(builder: (context) => ProfilePage());
      }
    case Routes.faq:
      {
        return CustomRoute(builder: (context) => FAQPage());
      }
    case Routes.parteners:
      {
        return CustomRoute(builder: (context) => PartnersPage());
      }

    // Tab page
    case Routes.home:
      {
        return CustomRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
    case Routes.campaign:
      {
        return CustomRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Campaigns));
      }
    case Routes.actions:
      {
        return CustomRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Actions));
      }

    // Learning
    case Routes.learningAll:
      {
        return CustomRoute(builder: (context) => LearningCentreAllPage());
      }

    // Beta
    case Routes.beta:
      {
        return CustomRoute(builder: (context) => BetaPage());
      }

    // TODO add a 404 page
    default:
      {
        return CustomRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
  }
};
