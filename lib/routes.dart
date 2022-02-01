import 'package:app/assets/routes/customRoute.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/Notification.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/pages/Tabs.dart';
import 'package:app/pages/action/ActionInfo.dart';
import 'package:app/pages/campaign/AllCampaignsPage.dart';
import 'package:app/pages/campaign/CampaignInfo/CampaignDetails.dart';
import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/campaign/CampaignPage.dart';
import 'package:app/pages/campaign/PastCampaignActionPage.dart';
import 'package:app/pages/intro/IntroPage.dart';
import 'package:app/pages/learning/LearningCentreAllPage.dart';
import 'package:app/pages/learning/LearningCentrePage.dart';
import 'package:app/pages/learning/LearningTopicPage.dart';
import 'package:app/pages/login/emailSentPage.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/pages/login/login_code_view.dart';
import 'package:app/pages/more/morePages/AccountDetailsPage.dart';
import 'package:app/pages/more/morePages/FAQPage.dart';
import 'package:app/pages/more/morePages/PartnersPage.dart';
import 'package:app/pages/causes/CauseOnboardingPage.dart';
import 'package:app/pages/causes/ChangeCausePage.dart';
import 'package:app/pages/other/InfoPage.dart';
import 'package:app/pages/other/NotificationPage.dart';
import 'package:app/pages/other/OrganisationPage.dart';
import 'package:app/pages/other/WebView.dart';
import 'package:flutter/material.dart';

class Routes {
  // Intro
  static const onBoarding = "onBoarding";
  static const intro = "intro";
  static const login = "login";
  static const emailSent = "emailSent";
  static const loginCodeInput = "loginCodeInput";
  static const loginLinkClicked = "loginLinkClicked";

  // Tab View Routes
  static const campaign = "campaign";
  static const actions = "actions";
  static const home = "home";
  static const explore = "explore";

  static const actionInfo = "actionInfo";
  static const campaignInfo = "campaignInfo";
  static const campaignDetails = "campaignDetails";

  // Causes
  static const causesPage = "causesPage";
  static const causesOnboardingPage = "causesOnboarding";

  // All campaigns (including past)
  static const allCampaigns = "allCampaigns";
  static const pastCampaignActionPage = "pastCampaignActionPage";

  // Other
  static const accountDetails = "accountDetails";
  static const profile = "profile";
  static const faq = "faq";
  static const parteners = "parteners";
  static const organisationPage = "organisationPage";
  static const info = "info";
  static const webview = "webview";
  static const notification = "notification";

  // Learning
  static const learningAll = "learning";
  static const learningSingle = "learningSingle";
  static const learningTopic = "learningTopic";
}

Function initRoutes = (RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {

    // Into
    case Routes.causesPage:
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
            builder: (context) => TabsPage(currentPage: TabPage.Home),
            settings: settings);
      }
    case Routes.explore:
      {
        return customRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Explore),
            settings: settings);
      }
    case Routes.campaign:
      {
        return customRoute(
            builder: (context) => CampaignPage(), settings: settings);
      }
    case Routes.campaignInfo:
      {
        print("navigating to campaignInfo");
        print(args);
        print(args is int);
        print(args is String);
        if (args is int) {
          print("navigating to campaignInfo");
          return customRoute(
              builder: (context) => CampaignInfo(
                    campaignId: args,
                  ),
              settings: settings);
        }
        if (args is ListCampaign) {
          return customRoute(
              builder: (context) => CampaignInfo(
                    campaign: args,
                  ),
              settings: settings);
        }
        return customRoute(
            builder: (context) => CampaignPage(), settings: settings);
      }
    case Routes.campaignDetails:
      {
        if (args is Campaign) {
          return customRoute(
              builder: (context) => CampaignDetails(args), settings: settings);
        }
        return customRoute(
            builder: (context) => CampaignPage(), settings: settings);
      }
    case Routes.allCampaigns:
      {
        return customRoute(
            builder: (context) => AllCampaignsPage(), settings: settings);
      }
    case Routes.actionInfo:
      {
        if (args is ActionInfoArguments) {
          return customRoute(
              builder: (context) => ActionInfo(args), settings: settings);
        }
        break;
      }
    //PastCampaignActionPage
    case Routes.pastCampaignActionPage:
      {
        if (args is Campaign) {
          return customRoute(
            builder: (context) => PastCampaignActionPage(args),
            settings: settings,
          );
        }
        //what do i return here ? atleast for now ?
        return customRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Home),
            settings: settings);
      }

    // Learning
    case Routes.learningAll:
      {
        return customRoute(
            builder: (context) => LearningCentreAllPage(), settings: settings);
      }
    case Routes.learningSingle:
      {
        if (args is int) {
          return customRoute(
              builder: (context) => LearningCentrePage(args),
              settings: settings);
        }
        return customRoute(
            builder: (context) => LearningCentreAllPage(), settings: settings);
      }
    case Routes.learningTopic:
      {
        if (args is LearningTopic) {
          return customRoute(
              builder: (context) => LearningTopicPage(args),
              settings: settings);
        }
        return customRoute(
            builder: (context) => LearningCentreAllPage(), settings: settings);
      }

    // Other
    case Routes.info:
      {
        if (args is InfoPageArgumnets) {
          return customRoute(
              builder: (context) => InfoPage(args), settings: settings);
        }
        return customRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Home),
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

    // Webview
    case Routes.webview:
      {
        if (args is WebViewArguments) {
          return customRoute(
              builder: (context) => WebViewPage(args), settings: settings);
        }
        if (args is String) {
          return customRoute(
              builder: (context) => WebViewPage(WebViewArguments(args)),
              settings: settings);
        }
        return customRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Home),
            settings: settings);
      }

    case Routes.notification:
      {
        if (args is InternalNotification) {
          return customRoute(
              builder: (context) => NotificationPage(args), settings: settings);
        }
        break;
      }

    // TODO add a 404 page
    default:
      {
        return customRoute(
            builder: (context) => TabsPage(currentPage: TabPage.Home),
            settings: settings);
      }
  }
};
