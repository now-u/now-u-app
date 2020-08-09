import 'package:app/pages/campaign/CampaignPage.dart';
import 'package:app/pages/other/OrganisationPage.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';

import 'package:app/pages/profile/profilePages/FAQPage.dart';
import 'package:app/pages/profile/profilePages/ProfilePage.dart';
import 'package:app/pages/profile/profilePages/PartnersPage.dart';
import 'package:app/pages/intro/IntroPage.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/pages/login/emailSentPage.dart';
import 'package:app/pages/other/InfoPage.dart';
import 'package:app/pages/other/WebView.dart';
import 'package:app/pages/Tabs.dart';
import 'package:app/pages/action/ActionInfo.dart';
import 'package:app/pages/campaign/LearningCentre/LearningCentreAllPage.dart';
import 'package:app/pages/campaign/LearningCentre/LearningCentrePage.dart';
import 'package:app/pages/campaign/LearningCentre/LearningTopicPage.dart';
import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/campaign/AllCampaignsPage.dart';

class Routes {
  // Intro
  static const intro = "intro";
  static const login = "login";
  static const emailSent = "emailSent";
  static const loginLinkClicked = "loginLinkClicked";

  // Tab View Routes
  static const campaign = "campaign";
  static const actions = "actions";
  static const home = "home";

  static const actionInfo = "actionInfo";
  static const campaignInfo = "campaignInfo";
 
  // All campaigns (including past)
  static const allCampaigns = "allCampaigns";

  // Other
  static const profile = "profile";
  static const faq = "faq";
  static const parteners = "parteners";
  static const organisationPage = "organisationPage";
  static const info = "info";
  static const webview = "webview";

  // Learning
  static const learningAll = "learning";
  static const learningSingle = "learningSingle";
  static const learningTopic = "learningTopic";
}

Function initRoutes = (RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {

    // Into
    case Routes.login:
      {
        if(args is LoginPageArguments) {
          return customRoute(builder: (context) => LoginPage(args), settings: settings);
        }
        return customRoute(builder: (context) => LoginPage(LoginPageArguments()), settings: settings);
      }
    case Routes.emailSent:
    case Routes.loginLinkClicked:
      {
        if (args is EmailSentPageArguments) {
          return customRoute(builder: (context) => EmailSentPage(args), settings: settings);
        }
        return customRoute(builder: (context) => LoginPage(LoginPageArguments()), settings: settings);
      }
    case Routes.intro:
      {
        return customRoute(builder: (context) => IntroPage(), settings: settings);
      }

    case Routes.profile:
      {
        return customRoute(builder: (context) => ProfilePage(), settings: settings);
      }
    case Routes.faq:
      {
        return customRoute(builder: (context) => FAQPage(), settings: settings);
      }
    case Routes.parteners:
      {
        return customRoute(builder: (context) => PartnersPage(), settings: settings);
      }

    // Tab page
    case Routes.home:
      {
        return customRoute( builder: (context) => TabsPage(currentPage: TabPage.Home), settings: settings);
      }
    case Routes.campaign:
      {
        return customRoute(builder: (context) => CampaignPage(), settings: settings);
      }
    case Routes.campaignInfo:
      {
        if (args is int) {
          return customRoute( builder: (context) => CampaignInfo( campaignId: args,), settings: settings);
        }
        if (args is Campaign) {
          return customRoute( builder: (context) => CampaignInfo( campaign: args,), settings: settings);
        }
        return customRoute(builder: (context) => CampaignPage(), settings: settings);
      }
    case Routes.allCampaigns: 
      {
        return customRoute(builder: (context) => AllCampaignsPage(), settings: settings);
      }
    case Routes.actions:
      {
        return customRoute(builder: (context) => TabsPage(currentPage: TabPage.Actions), settings: settings);
      }
    case Routes.actionInfo:
      {
        if (args is ActionInfoArguments) { 
          return customRoute( builder: (context) => ActionInfo( args ), settings: settings);
        }
        return customRoute(builder: (context) => TabsPage(currentPage: TabPage.Actions), settings: settings);
      }

    // Learning
    case Routes.learningAll:
      {
        return customRoute(builder: (context) => LearningCentreAllPage(), settings: settings);
      }
    case Routes.learningSingle:
      {
        if (args is int) {
          return customRoute(builder: (context) => LearningCentrePage(args), settings: settings);
        }
        return customRoute(builder: (context) => LearningCentreAllPage(), settings: settings);
      }
    case Routes.learningTopic:
      {
        if (args is LearningTopic) {
          return customRoute( builder: (context) => LearningTopicPage(args), settings: settings);
        }
        return customRoute(builder: (context) => LearningCentreAllPage(), settings: settings);
      }

    // Other
    case Routes.info:
      {
        if (args is InfoPageArgumnets) {
          return customRoute(builder: (context) => InfoPage(args), settings: settings);
        }
        return customRoute( builder: (context) => TabsPage(currentPage: TabPage.Home), settings: settings);
      }
    // Other
    case Routes.organisationPage:
      {
        if (args is Organisation) {
          return customRoute(builder: (context) => OraganisationInfoPage(args), settings: settings);
        }
        return customRoute(builder: (context) => PartnersPage(), settings: settings);
      }

    // Beta
    case Routes.webview:
      {
        if (args is WebViewArgumnets) {
          return customRoute(builder: (context) => WebViewPage(args), settings: settings);
        }
        if (args is String) {
          return customRoute(builder: (context) => WebViewPage(WebViewArgumnets(args)), settings: settings);
        }
        return customRoute(builder: (context) => TabsPage(currentPage: TabPage.Home), settings: settings);
      }

    // TODO add a 404 page
    default:
      {
        return customRoute( builder: (context) => TabsPage(currentPage: TabPage.Home), settings: settings);
      }
  }
};
