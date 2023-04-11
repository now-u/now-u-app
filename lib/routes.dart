import 'package:nowu/assets/routes/customRoute.dart';
import 'package:nowu/models/Campaign.dart';
import 'package:nowu/models/Notification.dart';
import 'package:nowu/models/Organisation.dart';
import 'package:nowu/pages/Tabs.dart';
import 'package:nowu/pages/action/ActionInfo.dart';
import 'package:nowu/pages/campaign/campaign_page.dart';
import 'package:nowu/pages/intro/IntroPage.dart';
import 'package:nowu/pages/login/emailSentPage.dart';
import 'package:nowu/pages/login/login.dart';
import 'package:nowu/pages/login/login_code_view.dart';
import 'package:nowu/pages/login/profile_setup.dart';
import 'package:nowu/pages/more/morePages/AccountDetailsPage.dart';
import 'package:nowu/pages/more/morePages/FAQPage.dart';
import 'package:nowu/pages/more/morePages/PartnersPage.dart';
import 'package:nowu/pages/causes/CauseOnboardingPage.dart';
import 'package:nowu/pages/causes/ChangeCausePage.dart';
import 'package:nowu/pages/other/InfoPage.dart';
import 'package:nowu/pages/other/NotificationPage.dart';
import 'package:nowu/pages/other/OrganisationPage.dart';
import 'package:nowu/pages/search/SearchPage.dart';
import 'package:nowu/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';

class Routes {
  // Intro
  static const onBoarding = "onBoarding";
  static const intro = "intro";
  static const login = "login";
  static const emailSent = "emailSent";
  static const loginCodeInput = "loginCodeInput";
  static const loginLinkClicked = "loginLinkClicked";
  static const profileSetup = "profileSetup";

  // Tab View Routes
  static const campaign = "campaign";
  static const actions = "actions";
  static const home = "home";
  static const explore = "explore";

  static const actionInfo = "actionInfo";
  static const campaignInfo = "campaignInfo";
  static const campaignDetails = "campaignDetails";

  // Causes
  static const causesEditPage = "causesEditPage";
  static const causesOnboardingPage = "causesOnboarding";

  // Other
  static const accountDetails = "accountDetails";
  static const profile = "profile";
  static const faq = "faq";
  static const parteners = "parteners";
  static const organisationPage = "organisationPage";
  static const info = "info";
  static const notification = "notification";
  static const search = "search";
}

Function initRoutes = (RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    // Into
    case Routes.causesEditPage:
      {
        return customRoute(
            builder: (context) => ChangeCausePage(), settings: settings);
      }
    case Routes.causesOnboardingPage:
      {
        return customRoute(
            builder: (context) => CauseOnboardingPage(), settings: settings);
      }
    case Routes.login:
      {
        if (args is LoginPageArguments) {
          return customRoute(
              builder: (context) => LoginPage(args), settings: settings);
        }
        return customRoute(
            builder: (context) => LoginPage(LoginPageArguments()),
            settings: settings);
      }
    case Routes.emailSent:
    case Routes.loginLinkClicked:
      {
        if (args is EmailSentPageArguments) {
          return customRoute(
              builder: (context) => EmailSentPage(args), settings: settings);
        }
        return customRoute(
            builder: (context) => LoginPage(LoginPageArguments()),
            settings: settings);
      }
    case Routes.loginCodeInput:
      {
        if (args is String) {
          return customRoute(
              builder: (context) => LoginCodePage(args), settings: settings);
        }
        return customRoute(
            builder: (context) => LoginPage(LoginPageArguments()),
            settings: settings);
      }
    case Routes.profileSetup:
      {
        return customRoute(
            builder: (context) => ProfileSetup(), settings: settings);
      }

    case Routes.intro:
      {
        return customRoute(
            builder: (context) => IntroPage(), settings: settings);
      }

    case Routes.faq:
      {
        return customRoute(builder: (context) => FAQPage(), settings: settings);
      }
    case Routes.parteners:
      {
        return customRoute(
            builder: (context) => PartnersPage(), settings: settings);
      }
    case Routes.accountDetails:
      {
        return customRoute(builder: (context) => AccountDetailsPage());
      }

    // Tab page
    case Routes.home:
      {
        return customRoute(
            builder: (context) =>
                TabsPage(TabsPageArguments(initialPage: TabPage.Home)),
            settings: settings);
      }
    case Routes.explore:
      {
        return customRoute(
            builder: (context) => TabsPage(TabsPageArguments(
                initialPage: TabPage.Explore,
                explorePageArgs: args is ExplorePageArguments ? args : null)),
            settings: settings);
      }
    case Routes.campaign:
      {
        if (args is ListCampaign) {
          return customRoute(
              builder: (context) => CampaignPage(args), settings: settings);
        }
        break;
      }
    case Routes.actionInfo:
      {
        if (args is ActionInfoArguments) {
          return customRoute(
              builder: (context) => ActionInfo(args), settings: settings);
        }
        break;
      }

    // Other
    case Routes.info:
      {
        if (args is InfoPageArgumnets) {
          return customRoute(
              builder: (context) => InfoPage(args), settings: settings);
        }
        return customRoute(
            builder: (context) =>
                TabsPage(TabsPageArguments(initialPage: TabPage.Home)),
            settings: settings);
      }
    // Other
    case Routes.organisationPage:
      {
        if (args is Organisation) {
          return customRoute(
              builder: (context) => OraganisationInfoPage(args),
              settings: settings);
        }
        return customRoute(
            builder: (context) => PartnersPage(), settings: settings);
      }

    case Routes.notification:
      {
        if (args is InternalNotification) {
          return customRoute(
              builder: (context) => NotificationPage(args), settings: settings);
        }
        break;
      }
    case Routes.search:
      {
		return customRoute(builder: (context) => SearchPage(), settings: settings);
      }

    // TODO add a 404 page
    default:
      {
        return customRoute(
            builder: (context) =>
                TabsPage(TabsPageArguments(initialPage: TabPage.Home)),
            settings: settings);
      }
  }
};
