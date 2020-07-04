import 'package:app/pages/campaign/CampaignPage.dart';
import 'package:app/pages/other/OrganisationPage.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/main.dart';
import 'package:app/models/Organisation.dart';

import 'package:app/pages/profile/profilePages/FAQPage.dart';
import 'package:app/pages/profile/profilePages/ProfilePage.dart';
import 'package:app/pages/profile/profilePages/PartnersPage.dart';
import 'package:app/pages/intro/IntroPage.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/pages/other/BetaPage.dart';
import 'package:app/pages/other/InfoPage.dart';
import 'package:app/pages/Tabs.dart';
import 'package:app/pages/campaign/LearningCentre/LearningCentreAllPage.dart';
import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';

class Routes {
  // Intro
  static const intro = "intro";
  static const login = "login";
  static const loginIssues = "loginIssues";

  // Tab View Routes
  static const campaign = "campaign";
  static const actions = "actions";
  static const home = "home";

  static const campaignInfo = "campaignInfo";

  // Other
  static const profile = "profile";
  static const faq = "faq";
  static const parteners = "parteners";
  static const organisationPage = "organisationPage";

  static const info = "info";

  // Learning
  static const learningAll = "learning";

  // Beta only
  static const beta = "beta";
//  static final authEmailSent = "authEmailSent";
}

Function initRoutes = (RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {

    // Into
    case Routes.login:
      {
        return CustomRoute(builder: (context) => LoginPage());
      }
    case Routes.loginIssues:
      {
        return CustomRoute(builder: (context) => LoginPage(retry: true));
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
            builder: (context) => CampaignPage());
      }
    case Routes.campaignInfo:
      {
        if (args is int) {
          return CustomRoute(
              builder: (context) => CampaignInfo(
                    campaignId: args,
                  ));
        }
        return CustomRoute(
            builder: (context) => CampaignPage());
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

    // Other
    case Routes.info:
      {
        if (args is InfoPageArgumnets) {
          return CustomRoute(
              builder: (context) => InfoPage(
                  args
              )
          );
        }
        return CustomRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
    // Other
    case Routes.organisationPage:
      {
        if (args is Organisation) {
          return CustomRoute(
              builder: (context) => OraganisationInfoPage(
                  args
              )
          );
        }
        return CustomRoute(
            builder: (context) => PartnersPage());
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
