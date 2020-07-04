import 'dart:io';

import 'package:app/pages/campaign/CampaignPage.dart';
import 'package:app/pages/other/OrganisationPage.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/Action.dart';

import 'package:app/pages/profile/profilePages/FAQPage.dart';
import 'package:app/pages/profile/profilePages/ProfilePage.dart';
import 'package:app/pages/profile/profilePages/PartnersPage.dart';
import 'package:app/pages/intro/IntroPage.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/pages/other/BetaPage.dart';
import 'package:app/pages/other/InfoPage.dart';
import 'package:app/pages/Tabs.dart';
import 'package:app/pages/campaign/LearningCentre/LearningCentreAllPage.dart';
import 'package:app/pages/campaign/LearningCentre/LearningCentrePage.dart';
import 'package:app/pages/campaign/LearningCentre/LearningTopicPage.dart';
import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';

class Routes {
  // Intro
  static const intro = "intro";
  static const login = "login";

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
  static const learningSingle = "learningSingle";
  static const learningTopic = "learningTopic";

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
        return customRoute(builder: (context) => LoginPage());
      }
    case Routes.intro:
      {
        return customRoute(builder: (context) => IntroPage());
      }

    case Routes.profile:
      {
        return customRoute(builder: (context) => ProfilePage());
      }
    case Routes.faq:
      {
        return customRoute(builder: (context) => FAQPage());
      }
    case Routes.parteners:
      {
        return customRoute(builder: (context) => PartnersPage());
      }

    // Tab page
    case Routes.home:
      {
        return customRoute( builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
    case Routes.campaign:
      {
        return customRoute(builder: (context) => CampaignPage());
      }
    case Routes.campaignInfo:
      {
        if (args is int) {
          return customRoute( builder: (context) => CampaignInfo( campaignId: args,));
        }
        if (args is Campaign) {
          return customRoute( builder: (context) => CampaignInfo( campaign: args,));
        }
        return customRoute(builder: (context) => CampaignPage());
      }
    case Routes.actions:
      {
        return customRoute(builder: (context) => TabsPage(currentPage: TabPage.Actions));
      }

    // Learning
    case Routes.learningAll:
      {
        return customRoute(builder: (context) => LearningCentreAllPage());
      }
    case Routes.learningSingle:
      {
        if (args is int) {
          return customRoute(builder: (context) => LearningCentrePage(args));
        }
        return customRoute(builder: (context) => LearningCentreAllPage());
      }
    case Routes.learningTopic:
      {
        if (args is LearningTopic) {
          return customRoute( builder: (context) => LearningTopicPage(args));
        }
        return customRoute(builder: (context) => LearningCentreAllPage());
      }

    // Other
    case Routes.info:
      {
        if (args is InfoPageArgumnets) {
          return customRoute(builder: (context) => InfoPage(args));
        }
        return customRoute( builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
    // Other
    case Routes.organisationPage:
      {
        if (args is Organisation) {
          return customRoute(builder: (context) => OraganisationInfoPage(args));
        }
        return customRoute(builder: (context) => PartnersPage());
      }

    // Beta
    case Routes.beta:
      {
        return customRoute(builder: (context) => BetaPage());
      }

    // TODO add a 404 page
    default:
      {
        return customRoute( builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
  }
};
