import 'dart:io';

import 'package:app/assets/routes/customIosRoute.dart';
import 'package:app/pages/campaign/CampaignPage.dart';
import 'package:app/pages/other/OrganisationPage.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
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
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => LoginPage())
            : CustomIosRoute(builder: (context) => LoginPage());
      }
    case Routes.intro:
      {
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => IntroPage())
            : CustomIosRoute(builder: (context) => IntroPage());
      }

    case Routes.profile:
      {
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => ProfilePage())
            : CustomIosRoute(builder: (context) => ProfilePage());
      }
    case Routes.faq:
      {
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => FAQPage())
            : CustomIosRoute(builder: (context) => FAQPage());
      }
    case Routes.parteners:
      {
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => PartnersPage())
            : CustomIosRoute(builder: (context) => PartnersPage());
      }

    // Tab page
    case Routes.home:
      {
        return Platform.isAndroid
            ? CustomRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Home))
            : CustomIosRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
    case Routes.campaign:
      {
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => CampaignPage())
            : CustomIosRoute(builder: (context) => CampaignPage());
      }
    case Routes.campaignInfo:
      {
        if (args is int) {
          return Platform.isAndroid
              ? CustomRoute(
                  builder: (context) => CampaignInfo(
                        campaignId: args,
                      ))
              : CustomIosRoute(
                  builder: (context) => CampaignInfo(
                        campaignId: args,
                      ));
        }
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => CampaignPage())
            : CustomIosRoute(builder: (context) => CampaignPage());
      }
    case Routes.actions:
      {
        return Platform.isAndroid
            ? CustomRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Actions))
            : CustomIosRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Actions));
      }

    // Learning
    case Routes.learningAll:
      {
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => LearningCentreAllPage())
            : CustomIosRoute(builder: (context) => LearningCentreAllPage());
      }

    // Other
    case Routes.info:
      {
        if (args is InfoPageArgumnets) {
          return Platform.isAndroid
              ? CustomRoute(builder: (context) => InfoPage(args))
              : CustomIosRoute(builder: (context) => InfoPage(args));
        }
        return Platform.isAndroid
            ? CustomRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Home))
            : CustomIosRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
    // Other
    case Routes.organisationPage:
      {
        if (args is Organisation) {
          return Platform.isAndroid
              ? CustomRoute(builder: (context) => OraganisationInfoPage(args))
              : CustomIosRoute(
                  builder: (context) => OraganisationInfoPage(args));
        }
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => PartnersPage())
            : CustomIosRoute(builder: (context) => PartnersPage());
      }

    // Beta
    case Routes.beta:
      {
        return Platform.isAndroid
            ? CustomRoute(builder: (context) => BetaPage())
            : CustomIosRoute(builder: (context) => BetaPage());
      }

    // TODO add a 404 page
    default:
      {
        return Platform.isAndroid
            ? CustomRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Home))
            : CustomIosRoute(
                builder: (context) => TabsPage(currentPage: TabPage.Home));
      }
  }
};
